## `v2016_09_14_1`

* `bitrise` (CLI): `1.4.0`


## `v2016_09_08_1`

* `Go`: 1.7.1


## `v2016_08_16_1`

* `Go`: 1.7


## `v2016_08_10_1`

* `bitrise` (CLI): `1.3.7`


## `v2016_07_21_1`

* `Go`: 1.6.3


## `v2016_07_15_1`

* `Node.js` (`v6`) in now pre-installed


## `v2016_07_14_1`

* `bitrise` (CLI): `1.3.6`


## `2016_07_02_1`

* CI specific `git` and SSH config, to make it easier to push back tags to repositories
* [git-lfs](https://git-lfs.github.com/) pre-installed


## `2016_06_18_1`

* `bitrise` (CLI): `1.3.5`
* Ruby: `2.3.1`


## `2016_05_28_1`

* Using `linux-image-extra-4.4.0-22-generic` for transition to Ubuntu 16.04


## `2016_05_27_1`

* Based on `ubuntu:16.04`
* `docker` : `1.11.1`
* `docker-compose` : `1.7.1`
* Ruby : `2.2.5`


## `2016_05_25_2`

* Fix in `bitrise.yml`, to be able to run `system_report.sh`, which needs access to `docker`


## `2016_05_25_1`

* "Checkpoint", before migration to Ubuntu 16.04


## `2016_05_14_1`

* `bitrise` (CLI): 1.3.4


## `2016_04_27_1`

* `bitrise` (CLI): 1.3.3


## `2016_04_23_1`

* `Go`: 1.6.2


## `2016_04_21_1`

* `bitrise` (CLI): 1.3.2


## `2016_04_19_1`

* `bitrise` (CLI): 1.3.1


## `2016_04_16_2`

* `/bitrise/cache` dir, exposed as `$BITRISE_CACHE_DIR` Env Var


## `2016_04_16_1`

* `bitrise` (CLI): 1.3.0
* `zip` pre-installed
* `Go`: 1.6.1


## `2016_03_26_1`

* `Docker`: 1.10.3


## `2016_03_11_1`

* `Go`: 1.6
* `Docker`: 1.10.2
* `docker-compose`: 1.6.2


## `2016_01_10_1`

* `$GOPATH` chmod change to `755`, because Ruby complains if `777` (`warning: Insecure world writable dir ... in PATH`)
* `tree` is now pre-installed


## `2016_01_09_1`

* `unzip` is now pre-installed
* `ruby` updated to `2.2.4`
* `go` updated to `1.5.2`
* `docker-compose` update to `1.5.2`
* `Go` Workspace dirs & envs (e.g. `$GOPATH`)
