import unittest
import imaplib
import smtplib
import json
import os
import re

from email.mime.text import MIMEText

ACCOUNTS = json.loads(os.getenv('TEST_ACCOUNTS', '{}'))

RE_DSN_FAILED = re.compile(r'could.+not.+be.+delivered', re.DOTALL)
RE_IS_SPAM = re.compile(r'original *message *before *SpamAssassin', re.DOTALL)


class EmailTest(unittest.TestCase):
    def setUp(self):
        self.accounts = ACCOUNTS.copy()
        for attrs in self.accounts.values():
            attrs['imap'] = imaplib.IMAP4(attrs['server'])
            attrs['imap'].login(attrs['address'], attrs['plainPasswd'])

    def tearDown(self):
        for attrs in self.accounts.values():
            attrs['imap'].logout()

    def send_email(self, sender, recipient, body, to_addr=None, subject=None):
        from_attrs = self.accounts[sender]
        from_addr = from_attrs['address']

        if to_addr is None:
            to_addr = self.accounts[recipient]['address']

        msg = MIMEText(body)
        msg['Subject'] = 'Test mail' if subject is None else subject
        msg['From'] = from_addr
        msg['To'] = to_addr

        with smtplib.SMTP(from_attrs['server'], port=587) as smtp:
            smtp.login(from_addr, from_attrs['plainPasswd'])
            smtp.sendmail(from_addr, [to_addr], msg.as_string())

    def wait_for_new_emails(self, user=None, folder='INBOX', search='(UNSEEN)'):
        newmails = []
        while len(newmails) == 0:
            for name, attrs in self.accounts.items():
                if user is not None and name != user:
                    continue
                try:
                    attrs['imap'].select(folder)
                except imaplib.IMAP4.error:
                    continue
                response = attrs['imap'].search(None, search)[1]
                unread_msg_ids = response[0].split()
                for msgid in unread_msg_ids:
                    result = attrs['imap'].fetch(msgid, '(UID BODY[TEXT])')[1]
                    newmails.append((msgid.strip().decode(), result[0][1].strip().decode()))
                attrs['imap'].close()
        return newmails

    def wait_for_one_email(self, user=None, folder='INBOX', search='(UNSEEN)'):
        newmails = self.wait_for_new_emails(user, folder, search)
        self.assertEqual(len(newmails), 1)
        return newmails[0]

    def mark_as_spam(self, user, msg_ids):
        for name, attrs in self.accounts.items():
            if name != user:
                continue
            attrs['imap'].select()
            attrs['imap'].copy(','.join(msg_ids), 'Spam')
            for num in msg_ids:
              attrs['imap'].store(num, '+FLAGS', '\\Deleted')
            attrs['imap'].expunge()
            attrs['imap'].close()

    def mark_as_ham(self, user, msg_ids):
        for name, attrs in self.accounts.items():
            if name != user:
                continue
            attrs['imap'].select('Spam')
            attrs['imap'].copy(','.join(msg_ids), 'INBOX')
            for num in msg_ids:
              attrs['imap'].store(num, '+FLAGS', '\\Deleted')
            attrs['imap'].expunge()
            attrs['imap'].close()

    def test_send_to_same_server(self):
        print ("test_send_to_same_server ~~~~")
        self.send_email('alice', 'bob', 'Hello Bob from Alice!')
        (_, text) = self.wait_for_one_email('bob')
        self.assertEqual(text, 'Hello Bob from Alice!')

    def test_send_to_different_server(self):
        print ("test_send_to_different_server ~~~~")
        self.send_email('foo', 'bob', 'Hello Bob from Foo!')
        (_, text) = self.wait_for_one_email('bob')
        self.assertEqual(text, 'Hello Bob from Foo!')

    def test_send_to_catchall(self):
        print ("test_send_to_catchall ~~~~")
        self.send_email('bar', 'spameater', 'Eat this!',
                        to_addr='spam@catchall.example')
        (_, text) = self.wait_for_one_email('spameater')
        self.assertEqual(text, 'Eat this!')

    def test_check_quota(self):
        print ("test_check_quota ~~~~")
        msg = ("Hello, how's your quota? " * 10).strip()
        self.send_email('alice', 'bar', msg)
        (_, text) = self.wait_for_one_email('bar')
        self.assertEqual(text, msg)

        msg = ("Where is your quota? " * 1000).strip()
        self.send_email('bob', 'bar', msg)
        (_, text) = self.wait_for_one_email('bob')
        self.assertRegex(text, RE_DSN_FAILED)

    def test_aliases(self):
        print ("test_aliases ~~~~")
        msg = 'Hi different Alice!'
        self.send_email('spameater', 'alice', msg,
                        to_addr='anotheralice@example.net')
        (_, text) = self.wait_for_one_email('alice')
        self.assertEqual(text, msg)

    def test_softbounce_nonexisting_address(self):
        print ("test_softbounce_nonexisting_address ~~~~")
        msg = 'Is there anyone?'
        self.send_email('alice', None, msg, to_addr='xxx@example.com')
        (_, text) = self.wait_for_one_email('alice')
        self.assertRegex(text, RE_DSN_FAILED)
        self.assertIn("This is the mail system at host mx.example.com",
                      text)

    def test_spam_filter(self):
        print ("test_spam_filter ~~~~")
        with self.assertRaises(smtplib.SMTPDataError) as cm:
            msg = 'XJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X'
            self.send_email('bob', 'spameater', msg,
                            to_addr='eatit@catchall.example')
        err = cm.exception
        self.assertEqual(554, err.smtp_code)
        self.assertEqual(b'5.7.1 Gtube pattern', err.smtp_error)

    def test_spam_filter_add_header(self):
        print ("test_spam_filter_add_header ~~~~")
        msg = 'YJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X'
        self.send_email('spameater', 'alice', msg,
                        to_addr='anotheralice@example.net')
        (_, text) = self.wait_for_one_email('alice', 'Spam')
        self.assertEqual(text, msg)

    def test_spam_filter_train(self):
        print ("test_spam_filter_train ~~~~")
        msg = 'This is a message to train the stats filter and see how it works.'
        self.send_email('spameater', 'foo', msg,
                        to_addr='foo@example.com')
        (msgid, text) = self.wait_for_one_email('foo')
        self.assertEqual(text, msg)
        self.mark_as_spam('foo', [msgid])
        (msgid, text) = self.wait_for_one_email('foo', 'Spam', 'ALL')
        self.assertEqual(text, msg)
        self.mark_as_ham('foo', [msgid])

if __name__ == '__main__':
    unittest.main(verbosity=2)
