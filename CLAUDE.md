# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository is a Docker encapsulation of the [`cheatset`](https://github.com/Kapeli/cheatset) Ruby gem, which generates Docsets for [Dash.app](https://kapeli.com/dash). The entire codebase is essentially a `Dockerfile` + `Gemfile` that packages `cheatset` for users without a Ruby toolchain.

## Key Commands

### Build the Docker image

```bash
docker build -t jonasbn/cheatset .
```

### Use the image to generate a docset

```bash
docker run --rm --volume "$PWD":/tmp -it --name cheatset jonasbn/cheatset generate sample.rb
```

The container mounts `$PWD` to `/tmp` (the container's working directory), so the `.rb` docset file must be in the current directory and referenced by filename only — not by path.

### Lint Markdown files locally

```bash
npx markdownlint-cli2 "**/*.md" --config .markdownlint.json
```

### Run spellcheck locally

```bash
pip install pyspelling
aspell --version  # requires aspell with English dictionary
pyspelling
```

New technical terms that fail spellcheck should be added to `.wordlist.txt`.

## Architecture

The project has three components:

1. **`Dockerfile`** — Builds from `ruby:3.2.10-slim-trixie` (pinned by SHA digest). Installs `build-essential`, `sqlite3`, and `libsqlite3-dev` because `cheatset`'s dependencies (nokogiri, sqlite3 gem) require C compilation. Sets `WORKDIR /tmp` so that mounted volumes at `/tmp` serve as the working directory. The entrypoint is `/usr/local/bundle/bin/cheatset`.

2. **`Gemfile` / `Gemfile.lock`** — Pin `cheatset` to an exact version (`1.4.6`). Both files are copied into the image and `Gemfile.lock` is used for reproducible builds (`bundle config set --local system 'true'` installs gems system-wide rather than into a bundle path).

3. **`sample.rb`** — A working example of the cheatset DSL. It demonstrates the structure of a docset file: `cheatsheet do` block containing `category do` blocks with `entry do` blocks.

## CI/CD

Three GitHub Actions workflows run on push:

- **`publish.yml`** — Builds and pushes multi-arch images (`linux/amd64`, `linux/arm64`) to both DockerHub (`jonasbn/cheatset`) and GHCR (`ghcr.io/jonasbn/docker-cheatset`). Tags include `latest`, branch name, commit SHA, and semver tags. Requires `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets.
- **`markdownlint.yml`** — Lints all `.md` files against `.markdownlint.json`.
- **`spellcheck.yml`** — Spellchecks all `.md` files using `pyspelling` + `aspell` (English), skipping content inside `<code>` and `<pre>` blocks.

## Conventions

- **GitHub Actions are pinned to commit SHAs** (not version tags) for supply chain security. When updating actions, use the full SHA of the desired version.
- **Dependabot** monitors Docker base image, GitHub Actions, and Bundler dependencies weekly.
- **Releases** are tagged semver versions (e.g. `0.22.0`). Changes to `master` without a tag are considered unstable/experimental. Document releases in `Changelog.md`.
- **Markdown style**: unordered lists use dashes; line-length rules are disabled; shell command examples prefixed with `$` are allowed (MD014 disabled).
- **EditorConfig**: 4-space indentation, UTF-8, final newline on all files.
