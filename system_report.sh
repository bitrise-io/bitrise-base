#!/bin/bash
set -e

echo
echo "=== Revision / ID ======================"
echo "* BITRISE_DOCKER_REV_NUMBER_BASE: $BITRISE_DOCKER_REV_NUMBER_BASE"
echo "========================================"
echo

# Make sure that the reported version is only
#  a single line!
echo
echo "=== Pre-installed tool versions ========"
echo "* Go: $(go version)"
echo "* Ruby: $(ruby --version)"
echo "  * bundler: $(bundle --version)"
echo "* Python: $(python --version 2>&1 >/dev/null)"
echo
echo "* git: $(git --version)"
echo "* mercurial/hg: $(hg --version | grep version)"
echo "* curl: $(curl --version | grep curl)"
echo "* wget: $(wget --version | grep 'GNU Wget')"
echo "* rsync: $(rsync --version | grep version)"
echo "* unzip: $(unzip -v | head -n 1)"
echo "* tar: $(tar --version | head -n 1)"
echo "* tree: $(tree --version)"
echo
echo "* docker: $(docker --version)"
echo "* docker-compose: $(docker-compose --version)"
echo
echo "* sudo: $(sudo --version 2>&1  | grep 'Sudo version')"
echo
echo "--- Bitrise CLI tool versions"
echo "* bitrise: $(bitrise --version)"
echo "* stepman: $(stepman --version)"
echo "* envman: $(envman --version)"
echo "========================================"
echo

echo
echo "=== System infos ======================="
echo "* Free disk space: $( df -kh / | grep '/' )"
echo "* Free RAM & swap:"
free -mh
echo "========================================"
echo
