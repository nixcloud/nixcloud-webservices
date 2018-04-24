import unittest
import imaplib
import smtplib
import json
import os

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

    def send_email(self, sender, recipient, body, subject=None):
        from_attrs = self.accounts[sender]
        to_attrs = self.accounts[recipient]

        from_addr = from_attrs['address']
        to_addr = to_attrs['address']

        msg = MIMEText(body)
        msg['Subject'] = 'Test mail' if subject is None else subject
        msg['From'] = from_addr
        msg['To'] = to_addr

        with smtplib.SMTP(from_attrs['server'], port=587) as smtp:
            smtp.login(from_addr, from_attrs['plainPasswd'])
            smtp.sendmail(from_addr, [to_addr], msg.as_string())

    def wait_for_new_emails(self):
        newmails = []
        while len(newmails) == 0:
            for name, attrs in self.accounts.items():
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
        newmails = self.wait_for_new_emails()
        self.assertEqual(len(newmails), 1)
        text = newmails[0].strip().decode()
        self.assertEqual(text, 'Hello Bob from Alice!')

    def test_send_to_different_server(self):
        self.send_email('foo', 'bob', 'Hello Bob from Foo!')
        newmails = self.wait_for_new_emails()
        self.assertEqual(len(newmails), 1)
        text = newmails[0].strip().decode()
        self.assertEqual(text, 'Hello Bob from Foo!')


if __name__ == '__main__':
    unittest.main(verbosity=2)
