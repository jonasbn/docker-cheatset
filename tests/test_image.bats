#!/usr/bin/env bats
# Tests for the jonasbn/cheatset Docker image.
# Run with: IMAGE_NAME=jonasbn/cheatset:test bats tests/

load helpers

# ---------------------------------------------------------------------------
# Shared state: generate a docset once for structural checks
# ---------------------------------------------------------------------------

setup_file() {
    export SHARED_TMPDIR
    SHARED_TMPDIR=$(mktemp -d)
    cp "$BATS_TEST_DIRNAME/fixtures/sample.rb" "$SHARED_TMPDIR/"
    docker run --rm -v "$SHARED_TMPDIR":/tmp "$IMAGE_NAME" generate sample.rb
}

teardown_file() {
    rm -rf "$SHARED_TMPDIR"
}

setup() {
    TMPDIR=$(mktemp -d)
}

teardown() {
    rm -rf "$TMPDIR"
}

# ---------------------------------------------------------------------------
# Smoke tests
# ---------------------------------------------------------------------------

@test "cheatset help exits 0" {
    run docker run --rm "$IMAGE_NAME" help
    [ "$status" -eq 0 ]
}

@test "cheatset help mentions generate command" {
    run docker run --rm "$IMAGE_NAME" help
    [[ "$output" == *"generate"* ]]
}

@test "cheatset version outputs 1.4.6" {
    run docker run --rm "$IMAGE_NAME" version
    [ "$status" -eq 0 ]
    [[ "$output" == *"1.4.6"* ]]
}

# ---------------------------------------------------------------------------
# Functional tests — generate from sample fixture
# ---------------------------------------------------------------------------

@test "generate exits 0" {
    cp "$BATS_TEST_DIRNAME/fixtures/sample.rb" "$TMPDIR/"
    run docker run --rm -v "$TMPDIR":/tmp "$IMAGE_NAME" generate sample.rb
    [ "$status" -eq 0 ]
}

@test "generate produces a .docset directory" {
    local docsets=("$SHARED_TMPDIR"/*.docset)
    [ -d "${docsets[0]}" ]
}

@test "generated docset contains Contents/Info.plist" {
    local docsets=("$SHARED_TMPDIR"/*.docset)
    [ -f "${docsets[0]}/Contents/Info.plist" ]
}

@test "generated docset contains SQLite index" {
    local docsets=("$SHARED_TMPDIR"/*.docset)
    [ -f "${docsets[0]}/Contents/Resources/docSet.dsidx" ]
}

@test "generated docset contains HTML documents" {
    local docsets=("$SHARED_TMPDIR"/*.docset)
    local html_count
    html_count=$(find "${docsets[0]}/Contents/Resources/Documents" -name "*.html" 2>/dev/null | wc -l)
    [ "$html_count" -gt 0 ]
}
