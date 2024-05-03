FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install -y rcm
RUN apt-get install -y vim curl git
RUN apt-get install -y zsh

# fix `character not in range` error
ENV LANG=C.UTF-8

WORKDIR /home/ubuntu/dotfiles
