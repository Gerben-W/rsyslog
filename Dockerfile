#update:04-03-2022

# Download base image ubuntu 20.04
FROM ubuntu:20.04

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update && apt upgrade -y
RUN apt install -y supervisor wget gnupg2

# Install Filebeat
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-8.x.list
RUN apt-get update && apt-get install filebeat

# Cleanup apt
RUN apt autoremove -y && rm -rf /var/lib/apt/lists/* && apt clean

# Define the ENV variable
ENV supervisor_conf /etc/supervisor/supervisord.conf

# Copy supervisor configuration
COPY files/supervisord.conf ${supervisor_conf}

# Volume configuration
VOLUME ["/etc/filebeat"]

# Copy start.sh script and define default command for the container
COPY files/start.sh /start.sh
CMD ["./start.sh"]
