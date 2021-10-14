FROM ruby:3.0.2-buster

RUN gem install cheatset

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
