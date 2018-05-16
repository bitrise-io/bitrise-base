## UPCOMING

## `v2018_05_16_1`

* `bitrise` (CLI): `1.16.1`

## `v2018_05_09_1`

* `bitrise` (CLI): `1.16.0`

## `v2018_04_11_1`

* `bitrise` (CLI): `1.15.0`

## `v2018_04_04_1`

* `Go`: `1.10.1`
* `Ruby`: `2.5.1`
* `bundler` is back in the installation game

## `v2018_03_13_1`

* `bitrise` (CLI): `1.14.0`

## `v2018_02_26_1`

* `Go`: `1.10.0`
* `docker`: `17.12.0`
* `docker-compose`: `1.19.0`

## `v2018_02_13_1`

* `bitrise` (CLI): `1.13.0`
* `Go`: `1.9.4`

## `v2018_02_05_1`

* `Go`: `1.9.3`

## `v2018_01_11_1`

* `bitrise` (CLI): `1.12.0`

## `v2018_01_08_1`

* `Ruby`: `2.5.0`

## `v2017_12_21_1`

* `Ruby`: `2.4.3`

## `v2017_12_13_1`

* `bitrise` (CLI): `1.11.0`

## `v2017_12_08_1`

* `aws` (CLI) preinstalled from `apt`
    * thanks [@bootstraponline](https://github.com/bootstraponline) for the [PR](https://github.com/bitrise-docker/bitrise-base/pull/160)!

## `v2017_11_14_1`

* `bitrise` (CLI): `1.10.1`

## `v2017_11_10_1`

* `Go`: `1.9.2`

## `v2017_10_10_1`

* `bitrise` (CLI): `1.10.0`

## `v2017_10_05_1`

* `Go`: `1.9.1`

## `v2017_09_27_1`

* `Ruby`: `2.4.2`

## `v2017_09_13_1`

* `bitrise` (CLI): `1.9.0`

## `v2017_09_07_1`

* `Go`: `1.9`
* `docker`: `17.06.2 CE`
* `docker-compose`: `1.16.0`

## `v2017_09_01_1`

* `GOPATH` env change from `/go` to `/bitrise/go`, for easier cross docker container sharing


## `v2017_08_14_1`

* `clang` is now pre-installed


## `v2017_08_08_1`

* `bitrise` (CLI): `1.8.0`


## `v2017_07_11_1`

* `bitrise` (CLI): `1.7.0`


## `v2017_06_29_1`

* NodeJS upgrade from v7 to v8


## `v2017_06_13_1`

* `bitrise` (CLI): `1.6.2`


## `v2017_05_29_1`

* `Go`: `1.8.3`


## `v2017_05_25_1`

* `BITRISE_TMP_DIR` env var set and related dir (`/bitrise/tmp`) created


## `v2017_05_11_1`

* `bitrise` (CLI): `1.6.1`


## `v2017_04_13_1`

* `Go`: `1.8.1`
* `Ruby`: `2.4.1`
* Lots of Dockerfile optimization


## `v2017_04_12_1`

* `bitrise` (CLI): `1.5.6`


## `v2017_04_03_1`

* `docker`: `17.03.1 CE`


## `v2017_03_27_1`

* `docker`: `17.03 CE`
* `docker-compose`: `1.11.2`


## `v2017_03_14_1`

* `bitrise` (CLI): `1.5.5`


## `v2017_02_14_1`

* `bitrise` (CLI): `1.5.4`
* `docker` upgrade from `1.11.1` to `1.12.6`
* `docker-compose` upgrade from `1.8.1` to `1.9.0`


## `v2017_01_11_1`

* `bitrise` (CLI): `1.5.2`
* `Node.js`: upgrade from `v6` to `v7`


## `v2016_12_15_1`

* `bitrise` (CLI): `1.5.1`


## `v2016_11_09_1`

* `bitrise` (CLI): `1.4.5`


## `v2016_10_24_1`

* `bitrise` (CLI): `1.4.3`


## `v2016_10_20_1`

* `Go`: 1.7.3
* `docker-compose`: 1.8.1


## `v2016_10_14_1`

* `bitrise` (CLI): `1.4.2`


## `v2016_10_12_1`

* `bitrise` (CLI): `1.4.1`


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
