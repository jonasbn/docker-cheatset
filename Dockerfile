# REF: https://docs.docker.com/engine/reference/builder/
# REF: https://hub.docker.com/_/ruby
FROM ruby:3.2.8-slim-bookworm@sha256:b42a6ec7c24b0105241429d41cab49c5d6d57e5b0df8c86cdf54cc405b9c3c79

# We point to the original repository for the image
LABEL org.opencontainers.image.source=https://github.com/jonasbn/docker-cheatset
LABEL org.opencontainers.image.title="cheatset"
LABEL org.opencontainers.image.description="Docker encapsulation of the cheatset command for generating Docsets for the Dash.app "
LABEL org.opencontainers.image.authors="jonasbn"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://github.com/jonasbn/docker-cheatset"
LABEL org.opencontainers.image.documentation="https://github.com/jonasbn/docker-cheatset#readme"
LABEL org.opencontainers.image.created="2025-05-21T12:00:00Z"

WORKDIR /usr/src/app

# We need C compiler and related tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install build-essential sqlite3 libsqlite3-dev pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle config set --local system 'true'
RUN bundle install

WORKDIR /tmp

ENTRYPOINT [ "/usr/local/bundle/bin/cheatset" ]
