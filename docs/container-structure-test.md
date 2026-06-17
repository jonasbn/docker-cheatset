# Container Structure Test

[container-structure-test](https://github.com/GoogleContainerTools/container-structure-test)
is a YAML-driven framework from Google for validating Docker image structure without running
the container as an end-to-end process. It complements the BATS functional tests by asserting
static image properties at build time.

## What it tests

- **Command tests** — run a command inside the image and assert exit code / stdout / stderr
- **File existence tests** — assert files or directories are present (or absent)
- **File content tests** — assert file contents match a regex
- **Metadata tests** — assert `ENTRYPOINT`, `CMD`, `ENV`, `EXPOSE`, `WORKDIR`, `LABEL` values

## Candidate tests for this image

```yaml
schemaVersion: "2.0.0"

commandTests:
  - name: "cheatset help exits 0"
    command: "cheatset"
    args: ["help"]
    exitCode: 0

  - name: "cheatset version is 1.4.6"
    command: "cheatset"
    args: ["version"]
    exitCode: 0
    expectedOutput: ["1.4.6"]

metadataTest:
  entrypoint: ["/usr/local/bundle/bin/cheatset"]
  workdir: "/tmp"
  labels:
    - key: "org.opencontainers.image.source"
      value: "https://github.com/jonasbn/docker-cheatset"
```

## Installation

Download the binary for your platform from the [releases page](https://github.com/GoogleContainerTools/container-structure-test/releases).

```bash
# macOS (arm64)
curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-darwin-arm64
chmod +x container-structure-test-darwin-arm64
sudo mv container-structure-test-darwin-arm64 /usr/local/bin/container-structure-test

# Linux (amd64)
curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64
chmod +x container-structure-test-linux-amd64
sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test
```

## Running locally

```bash
container-structure-test test \
  --image jonasbn/cheatset:latest \
  --config docs/container-structure-test.yaml
```

## GitHub Actions integration

```yaml
- name: Run container structure tests
  uses: docker/build-push-action@... # build first, load: true
  ...

- name: Install container-structure-test
  run: |
    curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64
    chmod +x container-structure-test-linux-amd64
    sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test

- name: Run structure tests
  run: |
    container-structure-test test \
      --image jonasbn/cheatset:test \
      --config docs/container-structure-test.yaml
```

## Trade-offs vs BATS

| | BATS | container-structure-test |
|---|---|---|
| Language | Shell | YAML |
| Functional tests | Yes | Limited (no volume mounts) |
| Structural/metadata checks | Verbose | Concise |
| CI install | Clone git repo | Single binary download |
| Multi-platform | Yes | Yes |

The two tools are complementary: container-structure-test for fast structural assertions,
BATS for end-to-end functional validation (volume mounts, output files).
