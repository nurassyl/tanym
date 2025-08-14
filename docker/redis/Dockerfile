# Base image
FROM redis:7.4

# Upgrade system
RUN apt-get update &&  apt-get upgrade -y

RUN apt-get install -y vim

ARG REDIS_PASSWORD

ENV REDIS_PASSWORD=${REDIS_PASSWORD}

