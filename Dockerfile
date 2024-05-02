FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install -y rcm

WORKDIR /home/ubuntu/dotfiles
