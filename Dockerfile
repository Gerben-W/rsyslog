#update:19-11-2023

# Download base image ubuntu 20.04
FROM ubuntu:jammy

ARG PUID=1000
ARG PGID=1000

# Update packages and install rsyslog
RUN apt update && apt upgrade -y 
RUN apt install rsyslog -y

# Copy files
COPY root/ /

# Cleanup cache repo
RUN apt clean && apt autoclean

STOPSIGNAL SIGQUIT

CMD ["sh", "/run.sh"]
