FROM ruby:3.0.2-buster

RUN gem install cheatset -v 1.4.3

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
