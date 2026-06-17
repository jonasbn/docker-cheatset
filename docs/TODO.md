# TODO

## Bundler version compatibility (Ruby 4.0 upgrade)

`Gemfile.lock` carries `BUNDLED WITH 2.4.20`, which predates the Bundler version
that ships with Ruby 4.0's gem ecosystem. No failure has been observed yet, but if a
future build step raises a Bundler version mismatch warning, this is the first place to
look. Regenerate `Gemfile.lock` with the Bundler version included in the Ruby 4.0 image
to eliminate the discrepancy.

## container-structure-test candidate config is stale

`docs/container-structure-test.md` contains a candidate YAML snippet that asserts
`cheatset version is 1.4.6`. This should be updated to `1.5.0` before the config is
promoted to an actual test file.
