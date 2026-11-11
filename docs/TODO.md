# TODO

## ~~Bundler version compatibility (Ruby 4.0 upgrade)~~ RESOLVED

`Gemfile.lock` now carries `BUNDLED WITH 4.0.14`, updated when the haml `~> 5.2` pin
was regenerated. The mismatch with the Ruby 4.0 image's bundler is resolved.

## Report haml escape_html regression to upstream cheatset

`cheatset` 1.5.0 added a `render_haml` compatibility shim to support haml 6+, but it
does not pass `escape_html: false` to the new `Haml::Template` API. haml 6+ changed
the default from `false` to `true`, so HTML content in docset entries (`name`, `notes`,
`html_notes`, `td_notes`, `introduction`) is escaped and renders as visible literal
text in Dash.

Until an upstream fix is released, haml is pinned to `~> 5.2` in `Gemfile` as a
workaround.

### Status

- A fix is prepared as commit `446270a` on the branch `fix-haml6-escape-html` in the
  local clone `~/develop/github-forks/cheatset`. It is not pushed and no PR is opened.
  The clone's `origin` is `Kapeli/cheatset` itself, so a personal fork is needed to push.
- The proposed change is one line in `lib/cheatset/creator.rb`: pass `escape_html: false`
  to `Haml::Template.new`.

### Verified findings

Checked by generating the same docset with haml 5.2.2 and haml 6.4.0, before and after
the change:

- haml 5 output is byte-identical before and after the change.
- haml 6 output matches haml 5 after the change, except for the two differences below.
- The shim's version check (`defined?(Haml::Template)`) is correct. On plain haml 5.2.2
  `Haml::Template` is not defined, so the haml 5 `Engine` branch is live. An earlier
  version of this note claimed the constant exists in both versions; that was wrong.
  Behaviour under Rails was not tested.
- The old upstream error `undefined method 'to_hash'` (issue 40) is what haml 6 raises
  for `Haml::Engine.new`. The 1.5.0 shim already handles that.
- Output is unescaped everywhere, including `title`, `category.id` and `header`. That
  matches haml 5, so the proposed fix keeps the old behaviour.

### Remaining differences on haml 6 (not covered by the fix)

haml 6 renders nil attribute values as empty attributes, where haml 5 left them out:

- `colspan=''` on `td.description`
- `id=''` on `tr`

Both look harmless in a browser, but `id=''` is technically invalid HTML. Worth a
separate upstream follow-up. Check the generated output once the pin is lifted.

### Next steps

1. Fork `Kapeli/cheatset`, push `fix-haml6-escape-html` and open the PR. The PR text is
   drafted and mentions the missing test suite and the two remaining differences.
2. When a cheatset release containing the fix is out:
    - bump `cheatset` in `Gemfile` and regenerate `Gemfile.lock`
    - relax the haml pin to `~> 6.4` and remove the explanatory comment in `Gemfile`
    - rebase or recreate Dependabot PR #199 (haml 6.4.0), which currently has merge
      conflicts with `master`
    - add a bats test that builds a docset with HTML in `notes` and `html_notes` and
      asserts the output is not escaped. The current suite does not catch this
      regression, which is how #199 passed all its checks.

## container-structure-test candidate config is stale

`docs/container-structure-test.md` contains a candidate YAML snippet that asserts
`cheatset version is 1.4.6`. This should be updated to `1.5.0` before the config is
promoted to an actual test file.
