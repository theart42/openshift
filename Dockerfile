# https://hub.docker.com/_/alpine
FROM alpine:3.12

# Install dependencies
RUN apk add --update --no-cache \
	bash \
	nmap  \
	nmap-ncat \
	netcat-openbsd \
	python3 \
	openssh \
	openssh-server \
	openrc \
	sudo \
	masscan \
	screen \
	libpcap \
	libpcap-dev \
	fping \
	&& rm -rf /var/cache/apk/*
RUN pass=$(echo date +%s | sha256sum | base64 | head -c 32; echo | mkpasswd) && echo "root:${pass}" | chpasswd
RUN addgroup -S sudo && adduser -S -s /bin/bash -G sudo -D hacktest && pass=$(echo date +%s | sha256sum | base64 | head -c 32; echo | mkpasswd) && echo "hacktest:${pass}" | chpasswd && mkdir -p /home/hacktest/.ssh && chown hacktest /home/hacktest && chown hacktest /home/hacktest/.ssh && chmod 700 /home/hacktest/.ssh
COPY authorized_keys /home/hacktest/.ssh/
RUN chown hacktest /home/hacktest/.ssh/authorized_keys && chmod 600 /home/hacktest/.ssh/authorized_keys
COPY sudoers /etc/sudoers
COPY entrypoint.sh /entrypoint.sh
COPY sshd_config /etc/ssh/
EXPOSE 2200

ENTRYPOINT ["/entrypoint.sh"]
