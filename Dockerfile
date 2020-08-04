# https://hub.docker.com/_/alpine
FROM alpine:3.12

# Install dependencies
RUN apk add --update --no-cache \
	bash \
	nmap  \
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
	&& rm -rf /var/cache/apk/*

RUN echo 'root:1234Geheim!' | chpasswd
RUN addgroup -S sudo && adduser -S -s /bin/bash -G sudo -D hacktest && echo 'hacktest:1234Geheim!' | chpasswd
COPY sudoers /etc/sudoers
COPY entrypoint.sh /entrypoint.sh
EXPOSE 22:2200

ENTRYPOINT ["/entrypoint.sh"]
