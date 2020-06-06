FROM ruby:2.6.6-stretch

RUN gem install cheatset

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
