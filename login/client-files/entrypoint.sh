#!/bin/sh

# fix permissions (prevent I Have No Name! issue)
chmod 600 /client
chmod 644 /etc/ldap.conf
chmod 644 /etc/passwd
chmod 644 /etc/shadow
chmod 644 /etc/group
chmod 644 /etc/gshadow
chmod 600 /etc/ldap.secret

service ssh start
service nscd restart
tail -f /dev/null
