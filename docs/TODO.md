# TODO

## ~~Bundler version compatibility (Ruby 4.0 upgrade)~~ RESOLVED

`Gemfile.lock` now carries `BUNDLED WITH 4.0.14`, updated when the haml `~> 5.2` pin
was regenerated. The mismatch with the Ruby 4.0 image's bundler is resolved.

## Report haml escape_html regression to upstream cheatset

`cheatset` 1.5.0 added a `render_haml` compatibility shim to support haml 6+, but it
does not pass `escape_html: false` to the new `Haml::Template` API. haml 6+ changed
the default from `false` to `true`, so HTML content in docset entries (notes,
html_notes, introduction) is escaped and renders as visible literal text in Dash.

The shim's version check (`defined?(Haml::Template)`) is also incorrect — `Haml::Template`
exists in both haml 5 and haml 6+, so the haml 5 `Engine` branch is dead code.

Report this to <https://github.com/Kapeli/cheatset> with a suggested fix: pass
`escape_html: false` when constructing the `Haml::Template` in `lib/cheatset/creator.rb`.

Until an upstream fix is released, haml is pinned to `~> 5.2` in `Gemfile` as a
workaround.

## container-structure-test candidate config is stale

`docs/container-structure-test.md` contains a candidate YAML snippet that asserts
`cheatset version is 1.4.6`. This should be updated to `1.5.0` before the config is
promoted to an actual test file.
