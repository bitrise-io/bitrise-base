FROM ubuntu:14.04

# Environments
# - Language
ENV LC_ALL "en_US.UTF-8"
ENV LANG "en_US.UTF-8"
# - CI
ENV CI "true"
ENV BITRISE_IO "true"
# - main dirs
ENV BITRISE_SOURCE_DIR "/bitrise/src"
ENV BITRISE_BRIDGE_WORKDIR "/bitrise/src"
ENV BITRISE_DEPLOY_DIR "/bitrise/deploy"

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git mercurial curl rsync ruby sudo

#
# Install Bitrise CLI
RUN curl -fL https://github.com/bitrise-io/bitrise/releases/download/1.2.2/bitrise-$(uname -s)-$(uname -m) > /usr/local/bin/bitrise
RUN chmod +x /usr/local/bin/bitrise
RUN bitrise setup --minimal

RUN mkdir -p /bitrise/src
WORKDIR /bitrise/src

CMD ls -alh