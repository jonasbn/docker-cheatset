# Docker encapsulation of cheatset

`cheatset` ([GitHub][cheatsetgithub]) is a Ruby application for generating documentation sets (Docsets) for **[Dash.app][dashapp]**, primarily focused at cheatsheets.

This repository is a Docker encapsulation for `cheatset` for those of us, who generate Docsets, but do not have a Ruby toolchain available or want the hassle of maintaining one.

Based on this repository you can either:

- Download a prebuilt image from DockerHub, based on the contents of this repository
- Or you can build your own based on the contents of this repository (please skip to the Build the image section)

## Specification

The Docker image is based on [the official Ruby Docker image][dockerhubruby], using the latest 2.5 version available of this image. See the `Dockerfile` for details.

It is based on the _larger_ image, not the _slim_ version since the dependencies of `cheatset` require compilation of C-based libraries.

### A note on DockerHub

The images are build from the GitHub repository master branch.

The recommended use is to use the latest release with a version tag. See `Changelog.md` for details. Whereas the tag `latest` just reflect the latest build based on the master branch.

The master branch might contain changes not tagged as released yet and can be regarded as _unstable_ or _experimental_. Changes such as corrections to documentation etc. will not be tagged until separately as a general rule, unless the changes are significant, but the aim is to keep the documentation relevant and up to date.

## Run the Image

The prebuilt `cheatset` Docker image is [available on DockerHub][dockerhubcheatset], or you can build it yourself based on this repository, see the section below on building.

```bash
$ docker pull jonasbn/cheatset:0.1.0
$ docker run --rm --volume $PWD:/tmp jonasbn/cheatset:0.1.0
```

And if you are want the latest build:

```bash
$ docker pull jonasbn/cheatset:lastest
$ docker run --rm --volume $PWD:/tmp jonasbn/cheatset:latest
```

As mentioned `latest` can be considered _unstable_ or _experimental_. Development is kept in branches, but new experimental features might make into master for wider evaluation.

With a single argument:

```bash
$ docker run --rm --volume "$PWD":/tmp -it --name cheatset jonasbn/cheatset help
Commands:
  cheatset generate FILE   # Generates cheatsheet out of a file
  cheatset help [COMMAND]  # Describe available commands or one specific command
```

With two arguments:

```bash
$ docker run --rm  -it --name cheatset jonasbn/cheatset help generate
Usage:
  cheatset generate FILE

Generates cheatsheet out of a file
```

Now lets generate something:

```bash
docker run --rm  -it --volume $PWD:/tmp --name cheatset jonasbn/cheatset generate samble.rb
```

And in our directory a `Sample.docset` directory appears.

Do note the `Sample.docset` was lifted from the [cheatset GitHub repository][cheatsetgithub] and is under respective copyright under the referenced repository and available under the MIT license.

This can be imported into **Dash.app**:

1. Open **Dash.app**
1. If you have the "Manage Docsets" available click that (or open a tab by clicking `+`)
1. Click `+` below the docsets
1. Pick "Add Local Docset" and navigate to the directory of you recently generated `Sample.docset`
1. Open it and it should now be listed in your left column, click on it a you should be good to go

Remember that upon regenerating you have to repeat the above steps, since changes are not automatically detected and imported, which mean that you can evaluate changes, without changing your other additions, which is also a good thing.

### Using an alias

The Docker invocation is a bit tedious, so it is recommended to either create a shell wrapper or a shell alias.

```bash
# run cheatset docker image in current directory and cleanup the image afterwards
$ alias cheatset='docker run --rm --volume "$PWD":/tmp -it --name cheatset jonasbn/cheatset'
```

Try it out:

```bash
$ cheatset
Commands:
  cheatset generate FILE   # Generates cheatsheet out of a file
  cheatset help [COMMAND]  # Describe available commands or one specific command
```

## Build the image

```bash
$ docker build -t jonasbn/cheatset .
```

Now that you have build the image, you can skip back to the "Run the image" section, which demonstrates how to use it.

Do note that cheatset does not work with Ruby 3 only Ruby 2 at this point so bumping the base image for the Docker image will not work, see change log entry for release 0.3.0.

Currently we observe the following warning with a Ruby version 2 based base image:

```text
/usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/creator.rb:89: warning: URI.escape is obsolete
/usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/creator.rb:99: warning: URI.escape is obsolete
/usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/creator.rb:99: warning: URI.escape is obsolete
/usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/creator.rb:89: warning: URI.escape is obsolete
/usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/creator.rb:99: warning: URI.escape is obsolete
```

Bumping to Ruby version 3 based base image, results in the following:

```text
/usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/creator.rb:89:in `block in generate_database': undefined method `escape' for URI:Module (NoMethodError)
    from /usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/creator.rb:88:in `each'
    from /usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/creator.rb:88:in `generate_database'
    from /usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/creator.rb:22:in `generate'
    from /usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/dsl/context.rb:9:in `generate'
    from /usr/local/bundle/gems/cheatset-1.4.2/lib/cheatset/cli.rb:27:in `generate'
    from /usr/local/bundle/gems/thor-1.1.0/lib/thor/command.rb:27:in `run'
    from /usr/local/bundle/gems/thor-1.1.0/lib/thor/invocation.rb:127:in `invoke_command'
    from /usr/local/bundle/gems/thor-1.1.0/lib/thor.rb:392:in `dispatch'
    from /usr/local/bundle/gems/thor-1.1.0/lib/thor/base.rb:485:in `start'
    from /usr/local/bundle/gems/cheatset-1.4.2/bin/cheatset:6:in `<top (required)>'
    from /usr/local/bundle/bin/cheatset:23:in `load'
    from /usr/local/bundle/bin/cheatset:23:in `<main>'
```

## Diagnostics

### `ERROR: "cheatset generate" was called with no arguments`

The complete error:

```text
ERROR: "cheatset generate" was called with no arguments
Usage: "cheatset generate FILE"
Deprecation warning: Thor exit with status 0 on errors. To keep this behavior, you must define `exit_on_failure?` in `Cheatset::CLI`
You can silence deprecations warning by setting the environment variable THOR_SILENCE_DEPRECATION.
```

1. You have to specify a Docset file (Ruby), eg. `sample.rb`

```bash
docker run --rm  -it --volume $PWD:/tmp --name cheatset jonasbn/cheatset generate samble.rb
```

### `No such file or directory`

```text
Traceback (most recent call last):
        10: from /usr/local/bundle/bin/cheatset:23:in `<main>'
         9: from /usr/local/bundle/bin/cheatset:23:in `load'
         8: from /usr/local/bundle/gems/cheatset-1.4.0/bin/cheatset:6:in `<top (required)>'
         7: from /usr/local/bundle/gems/thor-1.0.1/lib/thor/base.rb:485:in `start'
         6: from /usr/local/bundle/gems/thor-1.0.1/lib/thor.rb:392:in `dispatch'
         5: from /usr/local/bundle/gems/thor-1.0.1/lib/thor/invocation.rb:127:in `invoke_command'
         4: from /usr/local/bundle/gems/thor-1.0.1/lib/thor/command.rb:27:in `run'
         3: from /usr/local/bundle/gems/cheatset-1.4.0/lib/cheatset/cli.rb:26:in `generate'
         2: from /usr/local/bundle/gems/cheatset-1.4.0/lib/cheatset/cli.rb:26:in `new'
         1: from /usr/local/bundle/gems/cheatset-1.4.0/lib/cheatset/dsl/context.rb:5:in `initialize'
/usr/local/bundle/gems/cheatset-1.4.0/lib/cheatset/dsl/context.rb:5:in `read': No such file or directory @ rb_sysopen - dzil.rb (Errno::ENOENT)
```

1. Due to the mounting og a volume, You cannot specify an arbitrary path to the Docset file.
1. You have to work directly in the directory containing the Docset file

```bash
docker run --rm  -it --volume $PWD:/tmp --name cheatset jonasbn/cheatset generate samble.rb
```

You can _possibly_ adjust the Docker invocation accordingly.

## Resources and References

- [GitHub: cheatset][cheatsetgithub]
- [Dash.app][dashapp]
- [DockerHub: cheatset][dockerhubcheatset]
- [DockerHub: Ruby][dockerhubruby]
- [Blog post by Andrew Lock: "Packaging CLI programs into Docker images to avoid dependency hell"](https://andrewlock.net/packaging-cli-programs-into-docker-images-to-avoid-dependency-hell/)

[cheatsetgithub]: https://github.com/Kapeli/cheatset
[dashapp]: https://kapeli.com/dash
[dockerhubcheatset]: https://hub.docker.com/r/jonasbn/cheatset
[dockerhubruby]: https://hub.docker.com/_/ruby
