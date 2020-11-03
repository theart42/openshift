#!/bin/ash

# start lighttpd
/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf

# generate host keys if not present
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
