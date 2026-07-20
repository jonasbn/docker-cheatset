# frozen_string_literal: true

source "https://rubygems.org"

gem 'cheatset', '1.5.0'

# Pinned to haml 5.x: haml 6+ changed escape_html default to true, which causes
# HTML content in docset entries (notes, html_notes, introduction) to be escaped
# and rendered as visible literal text in Dash. cheatset 1.5.0's render_haml shim
# does not pass escape_html: false to the new Haml::Template API.
# Remove this pin once the upstream fix lands in Kapeli/cheatset.
gem 'haml', '~> 6.4'

