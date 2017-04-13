FROM ubuntu:16.04


# ------------------------------------------------------
# --- Environments and base directories

# Environments
# - Language
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

# Configs - tool versions
ENV TOOL_VER_BITRISE_CLI "1.5.6"
ENV TOOL_VER_RUBY "2.4.1"
ENV TOOL_VER_GO "1.8.1"
ENV TOOL_VER_DOCKER "17.03.1"
ENV TOOL_VER_DOCKER_COMPOSE "1.11.2"

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
# For locale gen
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales
# Do Locale gen
RUN locale-gen en_US.UTF-8

# Requiered for Bitrise CLI
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git mercurial curl wget rsync sudo expect
# Common, useful
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install zip unzip
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tree
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install imagemagick
# For PPAs
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common



# ------------------------------------------------------
# --- Pre-installed but not through apt-get

# install Ruby from source
#  from source: mainly because of GEM native extensions,
#  this is the most reliable way to use Ruby no Ubuntu if GEM native extensions are required
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev libsqlite3-dev
RUN wget -q http://cache.ruby-lang.org/pub/ruby/ruby-${TOOL_VER_RUBY}.tar.gz
RUN tar -xvzf ruby-${TOOL_VER_RUBY}.tar.gz
RUN cd ruby-${TOOL_VER_RUBY} && ./configure --prefix=/usr/local && make && make install
# cleanup
RUN rm -rf ruby-${TOOL_VER_RUBY}
RUN rm ruby-${TOOL_VER_RUBY}.tar.gz

RUN gem install bundler --no-document


# install Go
#  from official binary package
RUN wget -q https://storage.googleapis.com/golang/go${TOOL_VER_GO}.linux-amd64.tar.gz -O go-bins.tar.gz
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


# Install NodeJS
#  from official docs: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
RUN sudo apt-get install -y nodejs


# Install Yarn
# as described at: https://yarnpkg.com/en/docs/install#linux-tab
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && sudo apt-get install -y yarn

# Install docker
#  as described at: https://docs.docker.com/engine/installation/linux/ubuntu/
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-cache policy docker-ce

# For available docker-ce versions
#  you can run `sudo apt-get update && sudo apt-cache policy docker-ce`
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce=${TOOL_VER_DOCKER}~ce-0~ubuntu-$(lsb_release -cs)


# docker-compose
RUN curl -fL https://github.com/docker/compose/releases/download/${TOOL_VER_DOCKER_COMPOSE}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN docker-compose --version


# ------------------------------------------------------
# --- Bitrise CLI

#
# Install Bitrise CLI
RUN curl -fL https://github.com/bitrise-io/bitrise/releases/download/${TOOL_VER_BITRISE_CLI}/bitrise-$(uname -s)-$(uname -m) > /usr/local/bin/bitrise
RUN chmod +x /usr/local/bin/bitrise
RUN bitrise setup
RUN bitrise envman -version
RUN bitrise stepman -version
# setup the default StepLib collection to stepman, for a pre-warmed
#  cache for the StepLib
RUN bitrise stepman setup -c https://github.com/bitrise-io/bitrise-steplib.git
RUN bitrise stepman update


# ------------------------------------------------------
# --- SSH config

COPY ./ssh/config /root/.ssh/config

# ------------------------------------------------------
# --- Update Rubygems

RUN gem update --system --no-document

# ------------------------------------------------------
# --- Git config

RUN git config --global user.email builds@bitrise.io
RUN git config --global user.name "Bitrise Bot"


# ------------------------------------------------------
# --- Git LFS

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git-lfs
RUN git lfs install


# ------------------------------------------------------
# --- Cleanup, Workdir and revision

# Cleaning
RUN apt-get clean

WORKDIR $BITRISE_SOURCE_DIR

ENV BITRISE_DOCKER_REV_NUMBER_BASE v2017_04_12_1
CMD bitrise --version
