# Base Bitrise Docker image

Based on Ubuntu, with pre-installed [bitrise CLI](https://github.com/bitrise-io/bitrise).

This docker image is pre-cached on the related [bitrise.io](https://www.bitrise.io)
Virtual Machines.

**If you'd like to add a tool** to be pre-installed you can create a
Pull Request, adding your changes to the `Dockerfile` of this repository.
*Please also add* a related test/report to the `system_report.sh` file,
which is used to test & list the pre-installed tools.

When a new version of this stack is available on [bitrise.io](https://www.bitrise.io)
we'll run `system_report.sh` and post the result into
the [bitrise.io GitHub repository](https://github.com/bitrise-io/bitrise.io),
under the `system_reports` folder. The `system_report.sh` script can be run with `docker-compose` locally too,
with: `docker-compose run --rm app bash system_report.sh`.


## Deployment and versions on [Docker Hub](https://hub.docker.com/)

There are two images built from this repository:

* [docker-bitrise-base-alpha](https://hub.docker.com/r/bitriseio/docker-bitrise-base-alpha/) - built every day, tagged automatically
* [docker-bitrise-base](https://hub.docker.com/r/bitriseio/docker-bitrise-base/) - **"pinned"**, release version

The "Alpha" images are built and tagged every day, automatically. These are tested regularly with various tests,
but are **not production ready**.

Once an "Alpha" is properly tested and declared as *production ready*, a "pinned" version is created
and published. Pinned versions are considered production ready, and the "latest" pinned version
is pre-cached on the [bitrise.io](https://www.bitrise.io/) Linux/Android Virtual Machines.

This means that **if you want to build your own Docker image on top of this Docker image,
you should build it on top of `bitriseio/docker-bitrise-base:latest`**, which is the
latest tested, pinned, "production" version. Pinned versions are created and pre-cached weekly,
usually on Saturday.

> If you want to build your own Docker image on top of this image and you want to use it
> on [bitrise.io](https://www.bitrise.io/), you should do that on top of `bitriseio/docker-bitrise-base:latest`,
> __and make sure you add this image as a Linked Repository on Docker Hub__, or that you
> rebuild your image on every weekend, once the pinned "latest" version is updated,
> to benefit from the pre-cached image layers (**for quite a significant speed up!**).
> Other versions / tags of the image are not pre-cached,
> __only the most recent "latest" tagged version is pre-cached__ on [bitrise.io](https://www.bitrise.io/)!


## docker-compose template

A `docker-compose.yml` is also included, configured for quick testing.

To build the image with `docker-compose` all you have to do is: `docker-compose build`

Then to run `bitrise --version` in the container: `docker-compose run --rm app bitrise --version`

To log into an interactive `bash` shell **inside** the container just run: `docker-compose run --rm app /bin/bash` - when you want to exit just run `exit` inside the container.

For convenience / experimenting the `./_tmp` folder (which is in `.gitignore`)
will be shared to `/bitrise/tmp`, to make it easy for you to share files
with the container.

Every time you change your `Dockerfile` you'll have to run `docker-compose build` again,
so your next `docker-compose run` will run in the environment you specify in
the `Dockerfile`.


## Maintainer / Service Developer Notes

### Docker shared folders

If you want to use shared folders with this Docker image, to let e.g. a build to use `docker` from
the container, you should mount a shared folder into `/bitrise/`, and should include the following dirs
in that shared folder:

- /bitrise/src
- /bitrise/deploy
- /bitrise/cache
- /bitrise/prep
- /bitrise/tmp

For maximum compatibility you should share `/bitrise` from the host to `/bitrise` in the container.

Also worth to mention that doing this **will improve the performance** of file moves between these dirs,
if the whole `/bitrise` dir is shared as a single shared folder.
Due to how docker handles shared folders right now, if you move files between shared and non shared dirs
it'll have to do a full file copy,
while if you move files inside a shared dir (`/bitrise` in this case)
that will be a simple rename, no file copy required.
