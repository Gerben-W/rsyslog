#update:04-03-2022

# Download base image ubuntu 20.04
FROM alpine:3.18

# Update packages and install rsyslog
RUN cd /etc/apk/keys && \
	wget http://alpine.adiscon.com/rsyslog@lists.adiscon.com-5a55e598.rsa.pub && \
	echo 'http://alpine.adiscon.com/3.7/stable' >> /etc/apk/repositories && \
	apk update && \
	apk add rsyslog && \
	apk upgrade

# Cleanup cache repo
RUN apk cache clean

ENTRYPOINT ["rsyslog"]
