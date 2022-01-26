FROM ruby:3.1.0-buster

COPY Gemfile .

RUN bundle install

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
