#!/bin/python

import imaplib

email = 'your@email.com'
passw = 'passwd'

gmail = imaplib.IMAP4_SSL('imap.gmail.com', 993)
gmail.login(email, passw)
inbox = gmail.select('Inbox')
gmail_unread = len(gmail.search(None, 'UnSeen')[1][0].split())

print(gmail_unread)





