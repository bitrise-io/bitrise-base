FROM ubuntu:14.04


# ------------------------------------------------------
# --- Environments and base directories

# Environments
# - Language
RUN locale-gen en_US.UTF-8
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"
ENV LC_ALL "en_US.UTF-8"
# - CI
ENV CI "true"
ENV BITRISE_IO "true"
# - main dirs
ENV BITRISE_SOURCE_DIR "/bitrise/src"
ENV BITRISE_BRIDGE_WORKDIR "/bitrise/src"
ENV BITRISE_DEPLOY_DIR "/bitrise/deploy"
ENV BITRISE_CACHE_DIR "/bitrise/cache"

# create base dirs
RUN mkdir -p /bitrise/src
RUN mkdir -p /bitrise/deploy
RUN mkdir -p /bitrise/cache

# prep dir
RUN mkdir -p /bitrise/prep
WORKDIR /bitrise/prep


# ------------------------------------------------------
# --- Base pre-installed tools
RUN apt-get update -qq
# Requiered for Bitrise CLI
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git mercurial curl wget rsync sudo expect
# Common, useful
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install unzip
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install zip
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tree
# For PPAs
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common


# ------------------------------------------------------
# --- Pre-installed but not through apt-get

# install Ruby from source
#  from source: mainly because of GEM native extensions,
#  this is the most reliable way to use Ruby no Ubuntu if GEM native extensions are required
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
RUN wget -q http://cache.ruby-lang.org/pub/ruby/ruby-2.2.4.tar.gz
RUN tar -xvzf ruby-2.2.4.tar.gz
RUN cd ruby-2.2.4 && ./configure --prefix=/usr/local && make && make install
# cleanup
RUN rm -rf ruby-2.2.4
RUN rm ruby-2.2.4.tar.gz

RUN gem install bundler --no-document


# install Go
#  from official binary package
RUN wget -q https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz -O go-bins.tar.gz
RUN tar -C /usr/local -xvzf go-bins.tar.gz
RUN rm go-bins.tar.gz
# ENV setup
ENV PATH $PATH:/usr/local/go/bin
# Go Workspace dirs & envs
# From the official Golang Dockerfile
#  https://raw.githubusercontent.com/docker-library/golang/master/1.5/Dockerfile
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
# 755 because Ruby complains if 777 (warning: Insecure world writable dir ... in PATH)
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 755 "$GOPATH"


# Install docker
#  as described at: https://docs.docker.com/engine/installation/ubuntulinux/
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# Ubuntu Trusty 14.04 (LTS)
RUN echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' > /etc/apt/sources.list.d/docker.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get purge lxc-docker*
RUN DEBIAN_FRONTEND=noninteractive apt-cache policy docker-engine
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y linux-image-extra-`uname -r`
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y docker-engine=1.10.3-0~trusty


# docker-compose
RUN curl -fL https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN docker-compose --version


# ------------------------------------------------------
# --- Bitrise CLI

#
# Install Bitrise CLI
RUN curl -fL https://github.com/bitrise-io/bitrise/releases/download/1.3.4/bitrise-$(uname -s)-$(uname -m) > /usr/local/bin/bitrise
RUN chmod +x /usr/local/bin/bitrise
RUN bitrise setup --minimal
RUN envman -version
RUN stepman -version
# setup the default StepLib collection to stepman, for a pre-warmed
#  cache for the StepLib
RUN stepman setup -c https://github.com/bitrise-io/bitrise-steplib.git
RUN stepman update


# ------------------------------------------------------
# --- Cleanup, Workdir and revision

# Cleaning
RUN apt-get clean

WORKDIR $BITRISE_SOURCE_DIR

ENV BITRISE_DOCKER_REV_NUMBER_BASE 2016_05_14_1
CMD bitrise --version
