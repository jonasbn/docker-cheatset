# Change log for Docker-cheatset

## 0.19.0 2025-05-21 maintenance release

- Improved management of the Docker image and enabled pushing to GitHub Container Registry (GHCR) via GitHub Actions

- Added some more meta-data to the Dockerfile

## 0.18.0 2025-05-21 Feature/maintenance release

- Bumped Docker base image from Ruby 3.2.6-slim-bullseye to 3.2.8-slim-bookworm

- Pinned Docker base image

- Pinned GitHub Actions

- Added build of arm64 architecture/platform as requested by @kspeeckaert via issue [#123](https://github.com/jonasbn/docker-cheatset/issues/123)

## 0.17.0 2024-11-10 Maintenance release

- Bumped Docker base image from Ruby 3.2.3-slim-bullseye to 3.2.6-slim-bullseye, via PR [#108](https://github.com/jonasbn/docker-cheatset/pull/108) from @jonasbn

## 0.16.0 2024-07-18 Maintenance release

- Bumped Docker base image from Ruby 3.2.2-slim-bullseye to 3.2.3-slim-bullseye, via PR [#82](https://github.com/jonasbn/docker-cheatset/pull/82) from @snyk-bot

- Cleaned up dependencies after multiple tests and updates, dependencies might be older, but the build works.

- Changes to build to be based on `Gemfile.lock` instead of `Gemfile` so the build is more predictable

## 0.15.0 2023-07-10 Maintenance release

- Bumped dependencies:
  - sanitize from version 6.0.1 to 6.0.2
  - nokogiri to 1.15.3
  - racc to 1.7.1
  - mini_portile2 to 2.8.2
  - All via PR [#63](https://github.com/jonasbn/docker-cheatset/pull/63) from @dependabot

- Bumped dependency: nokogiri from version 1.14.0 to 1.14.3, via PR [#60](https://github.com/jonasbn/docker-cheatset/pull/60) from @dependabot

## 0.14.0 2023-04-07 Maintenance release

- Bumped from Ruby 3.2.1-slim-bullseye to 3.2.2-slim-bullseye, via PR [#59](https://github.com/jonasbn/docker-cheatset/pull/59) from @dependabot

## 0.13.0 2023-04-06 Maintenance release

- Bumped from Ruby 3.2.0-slim-bullseye to 3.2.1-slim-bullseye, via PR [#56](https://github.com/jonasbn/docker-cheatset/pull/56) from @dependabot

- Bumped dependency: sanitize from version 6.0.0 to 6.0.1, via PR [#55](https://github.com/jonasbn/docker-cheatset/pull/55) from @dependabot

## 0.12.0 2023-01-04 Maintenance release

- Bumped from Ruby 3.1.3-slim-bullseye to 3.2.0-slim-bullseye, via PR [#52](https://github.com/jonasbn/docker-cheatset/pull/52) from @dependabot

- Added `Gemfile.lock` to Docker image generation

- Bumped Bundler version in `Gemfile.lock`

- Renamed example file from `samble.rb` to `sample.rb`, thanks to @suredream who patched cheatset via PR [#39](https://github.com/Kapeli/cheatset/pull/39), I believe I am the one who introduced this spelling error, both in my own repository and in the cheatset repository

## 0.11.0 2022-12-03 Maintenance release

- Bumped from Ruby 3.1.2-slim-bullseye to 3.1.3-slim-bullseye, via PR [#49](https://github.com/jonasbn/docker-cheatset/pull/49) from @dependabot

- Bumped from Ruby 3.1.1-slim-bullseye to 3.1.2-slim-bullseye, via PR [#38](https://github.com/jonasbn/docker-cheatset/pull/38) from @dependabot

## 0.10.0 2022-02-21 Maintenance release

- Bumped from Ruby 3.1.0-slim-bullseye to 3.1.1-slim-bullseye, via PR [#32](https://github.com/jonasbn/docker-cheatset/pull/32) from @dependabot

## 0.9.0 2022-02-02 Maintenance release

- `cheatset` has been updated with a bug fix release: [1.4.6](https://rubygems.org/gems/cheatset/versions/1.4.6) for details please see the [GitHub repository](https://github.com/Kapeli/cheatset) - thanks @dependabot

- The Docker base image has been changed to a _slim_ variation, which reduces the image size significantly

## 0.8.0 2022-01-26 Maintenance release

`cheatset` has been updated with a bug fix release: [1.4.5](https://rubygems.org/gems/cheatset/versions/1.4.5) for details please see the [GitHub repository](https://github.com/Kapeli/cheatset) - thanks @dependabot

- Changed Docker base image from from Ruby 3.1.0-buster to 3.1.0-bullseye. Meaning we are changing from Debian 10 to Debian 11. This aims to decrease the exposure to number of known vulnerabilities.

Data from Snyk

- ruby.3.1.0-buster (388 vulnerabilities), by severity
  - 6 critical
  - 42 high
  - 68 medium
  - 272 low

[Report from Snyk](https://snyk.io/advisor/docker/ruby/3.1.0-bullseye), 29 days old at the time of writing

- ruby:3.1.0-bullseye (196), by severity
  - 29 high
  - 35 medium
  - 132 low

Manual scan:

- ruby:3.1.0-bullseye (196), by severity
  - 11 critical
  - 18 high
  - 35 medium
  - 132 low

This does increase the number of critical issues, but it decreases the total of vulnerabilities.

## 0.7.0 2022-01-04 Maintenance release

- Bumped from Ruby 3.0.3-buster to 3.1.0-buster, via PR [#24](https://github.com/jonasbn/docker-cheatset/pull/24) from @dependabot

## 0.6.0 2021-12-01 Maintenance release

- Bumped from Ruby 3.0.2-buster to 3.0.3-buster, via PR [#19](https://github.com/jonasbn/docker-cheatset/pull/19) from @dependabot

## 0.5.0 2021-11-12 Maintenance release

- `cheatset` gem updated to version [1.4.4](https://rubygems.org/gems/cheatset/versions/1.4.4) via PR [#18](https://github.com/jonasbn/docker-cheatset/pull/18) from @holyjak

## 0.4.0 2021-10-14 Maintenance release

- `cheatset` gem updated to version [1.4.3](https://rubygems.org/gems/cheatset/versions/1.4.3). [My upstream PR](https://github.com/Kapeli/cheatset/pull/35) was accepted and the deprecated URI and `cheatset` now works with Ruby 3

- Pinned the version of `cheatset` as recommended in this [blog post by Florin Lipan](https://lipanski.com/posts/dockerfile-ruby-best-practices#3-pin-your-application-dependencies)

- @dependabot provided a PR [#12](https://github.com/jonasbn/docker-cheatset/pull/12) updating Ruby base image from 2.7-buster to 3.0.2-buster

## 0.3.0 2021-02-07 Maintenance release

- Bumped from Ruby 2.6.6-stretch to 2.7-buster, via PR [#3](https://github.com/jonasbn/docker-cheatset/pull/3)

- Warnings on URI being deprecated, have created [a PR upstream](https://github.com/Kapeli/cheatset/pull/35) exchanging URI for CGI as [per recommendation from the documentation](https://rubyapi.org/2.7/o/uri/escape). `cheatset` version 1.4.2 does not work with Ruby 3

## 0.2.0 2020-06-06 Maintenance release

- @dependabot provided a PR [#1](https://github.com/jonasbn/docker-cheatset/pull/1) updating Ruby base image from 2.5-stretch to 2.6.6-stretch

## 0.1.0 2020-05-10 Feature release

- Initial release
- Basic use case for generation of documentation sets implemented, meaning support for the `generate` command
