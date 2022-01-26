# Change log for Docker-cheatset

`cheatset` has been updated with a bug fix release: [1.4.5](https://rubygems.org/gems/cheatset/versions/1.4.5) fpr details please see the [GitHub repository](https://github.com/Kapeli/cheatset).

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
