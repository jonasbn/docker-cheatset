---
name: update-base-image
description: Guide updating the pinned Ruby base image tag and sha256 digest in the Dockerfile, then record it in Changelog.md
disable-model-invocation: true
---

## Steps

1. **Find the latest Ruby slim-trixie tag** at https://hub.docker.com/_/ruby/tags?name=slim-trixie

2. **Get the sha256 digest** for the new tag (both amd64 and arm64 are published; use the multi-arch manifest digest):
   ```bash
   docker pull ruby:<new-tag>-slim-trixie
   docker inspect ruby:<new-tag>-slim-trixie --format '{{index .RepoDigests 0}}'
   ```

3. **Update the Dockerfile FROM line** — replace both the tag and the digest:
   ```
   FROM ruby:<new-tag>-slim-trixie@sha256:<new-digest>
   ```

4. **Build locally to verify** the new base image works:
   ```bash
   docker build -t jonasbn/cheatset:test .
   docker run --rm --volume "$PWD":/tmp jonasbn/cheatset:test generate sample.rb
   ```

5. **Add a Changelog.md entry** under `[Unreleased]`:
   ```
   - Updated Ruby base image to <new-tag>-slim-trixie
   ```
