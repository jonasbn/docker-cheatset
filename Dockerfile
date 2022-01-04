FROM ruby:3.1.0-buster

RUN gem install cheatset -v 1.4.4

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
