#update:04-03-2022

# Download base image ubuntu 20.04
FROM ubuntu:20.04

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update && apt upgrade -y && \
	apt install -y supervisor curl gnupg2

# Install Filebeat
RUN curl -sL https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
RUN echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-8.x.list && \
RUN apt-get update && apt-get install filebeat

# Cleanup apt
RUN apt autoremove -y && rm -rf /var/lib/apt/lists/* && apt clean

# copy local files
COPY root/ /

# ports and volumes
VOLUME /config
