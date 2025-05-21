# REF: https://docs.docker.com/engine/reference/builder/
# REF: https://hub.docker.com/_/ruby
FROM ruby:3.4.4-slim-bookworm@sha256:5d7149ee7eda2420d1b2bc3af78798de9eac3098e910c44a3ddd93da2a4130ca

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
