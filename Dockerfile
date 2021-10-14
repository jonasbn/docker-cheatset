FROM ruby:2.7-buster

RUN gem install cheatset -v 1.4.3

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
