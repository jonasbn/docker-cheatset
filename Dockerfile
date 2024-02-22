# REF: https://docs.docker.com/engine/reference/builder/
# REF: https://hub.docker.com/_/ruby
FROM ruby:slim-bullseye

# We point to the original repository for the image
LABEL org.opencontainers.image.source https://github.com/jonasbn/docker-cheatset

# We need C compiler and related tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install build-essential sqlite3 libsqlite3-dev pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

WORKDIR /tmp

ENTRYPOINT [ "cheatset" ]
