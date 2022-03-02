#update:02-03-2022

FROM ubuntu:20.04
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        rsyslog \
    && apt-get clean
