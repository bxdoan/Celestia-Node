#!/bin/bash

#region printing util
EC='\033[0m'    # end coloring
HL='\033[0;33m' # high-lighted color
ER='\033[0;31m' # red color
CM='\033[0;32m' # comment color
GR='\033[0;32m' # green color
WH='\033[0;37m' # white color
CONTAINER_NAME="gallant_austin"
repo_name="Celestia-Node"

printf "${GR}Updating the server, installing docker...\n${EC}"
printf "${GR}======================================================\n${EC}"
apt update && sudo apt upgrade -y
apt install docker.io curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y

# install go
if [ ! $GOROOT ]; then
  printf "${GR}Installing Go...\n${EC}"
  printf "${GR}======================================================\n${EC}"
  go_version="1.19.4"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # if mac os
    if [[ $(uname -m) == *"ar"* ]]; then
      version_go="go$go_version.darwin-arm64.tar.gz"
    else
      version_go="go$go_version.darwin-amd64.tar.gz"
    fi
  else
    # if linux in arm or aarch architecture
    if [[ $(uname -m) == *"ar"* ]]; then
      version_go="go$go_version.linux-arm64.tar.gz"
    else
      version_go="go$go_version.linux-amd64.tar.gz"
    fi
  fi

  wget https://golang.org/dl/$version_go
  rm -rf /usr/local/go
  tar -C /usr/local -xzf $version_go
  rm $version_go
  echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
  source $HOME/.bash_profile
fi


printf "${GR}Installing Celestia Node...\n${EC}"
printf "${GR}======================================================\n${EC}"
cd $HOME
image_version=$(curl -s https://api.github.com/repos/celestiaorg/celestia-node/releases/latest | grep -oP '"tag_name": "v\K(.*)(?=")')
printf "Install latest image: $image_version\n"
rm -rf celestia-node
git clone https://github.com/celestiaorg/celestia-node.git
cd celestia-node/
git checkout tags/v$image_version
make install
make cel-key
