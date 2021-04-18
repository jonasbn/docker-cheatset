FROM ruby:3.0.1-buster

RUN gem install cheatset

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
