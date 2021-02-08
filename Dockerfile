FROM ruby:3.0.0-buster

RUN gem install cheatset

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
