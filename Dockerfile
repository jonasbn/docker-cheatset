FROM ruby:2.7-buster

RUN gem install cheatset

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
