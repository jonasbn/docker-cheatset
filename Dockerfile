FROM ruby:3.1.0-bullseye

COPY Gemfile .

RUN bundle install

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
