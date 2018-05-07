import unittest
import imaplib
import smtplib
import json
import os
import re

from email.mime.text import MIMEText

ACCOUNTS = json.loads(os.getenv('TEST_ACCOUNTS', '{}'))


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

    def wait_for_new_emails(self, user=None):
        newmails = []
        while len(newmails) == 0:
            for name, attrs in self.accounts.items():
                if user is not None and name != user:
                    continue
                try:
                    attrs['imap'].select()
                except imaplib.IMAP4.error:
                    continue
                response = attrs['imap'].search(None, '(UNSEEN)')[1]
                unread_msg_ids = response[0].split()
                for msgid in unread_msg_ids:
                    result = attrs['imap'].fetch(msgid, '(UID BODY[TEXT])')[1]
                    newmails.append(result[0][1])
                attrs['imap'].close()
        return newmails

    def test_send_to_same_server(self):
        self.send_email('alice', 'bob', 'Hello Bob from Alice!')
        newmails = self.wait_for_new_emails('bob')
        self.assertEqual(len(newmails), 1)
        text = newmails[0].strip().decode()
        self.assertEqual(text, 'Hello Bob from Alice!')

    def test_send_to_different_server(self):
        self.send_email('foo', 'bob', 'Hello Bob from Foo!')
        newmails = self.wait_for_new_emails('bob')
        self.assertEqual(len(newmails), 1)
        text = newmails[0].strip().decode()
        self.assertEqual(text, 'Hello Bob from Foo!')

    def test_send_to_catchall(self):
        self.send_email('bar', 'spameater', 'Eat this!',
                        to_addr='spam@catchall.example')
        newmails = self.wait_for_new_emails()
        self.assertEqual(len(newmails), 1)
        text = newmails[0].strip().decode()
        self.assertEqual(text, 'Eat this!')

    def test_check_quota(self):
        msg = ("Hello, how's your quota? " * 10).strip()
        self.send_email('alice', 'bar', msg)
        newmails = self.wait_for_new_emails('bar')
        self.assertEqual(len(newmails), 1)
        text = newmails[0].strip().decode()
        self.assertEqual(text, msg)

        msg = ("Where is your quota? " * 1000).strip()
        self.send_email('bob', 'bar', msg)
        newmails = self.wait_for_new_emails('bob')
        self.assertEqual(len(newmails), 1)
        text = newmails[0].strip().decode()
        overquota = re.compile(r'could.+not.+be.+delivered', re.DOTALL)
        self.assertRegex(text, overquota)


if __name__ == '__main__':
    unittest.main(verbosity=2)
