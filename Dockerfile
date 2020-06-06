FROM ruby:2.6.6-alpine3.11

RUN gem install cheatset

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
