FROM ruby:2.5-stretch

RUN gem install cheatset

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
