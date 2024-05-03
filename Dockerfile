FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install -y rcm
RUN apt-get install -y vim curl git

WORKDIR /home/ubuntu/dotfiles
