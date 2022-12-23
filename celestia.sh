#!/bin/bash

#region printing util
EC='\033[0m'    # end coloring
HL='\033[0;33m' # high-lighted color
ER='\033[0;31m' # red color
CM='\033[0;32m' # comment color
GR='\033[0;32m' # green color
WH='\033[0;37m' # white color
CONTAINER_NAME="gallant_austin"

printf "${GR}Updating the server, installing docker...\n${EC}"
printf "${GR}======================================================\n${EC}"
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io -y

if [ ! $node_type ]; then
	read -p "Enter your NODE TYPE you want to run (light/bridge/full): " node_type
fi

# install go
if [ ! $GOROOT ]; then
  printf "${GR}Installing Go...\n${EC}"
  printf "${GR}======================================================\n${EC}"
  go_version="1.19.1"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # if mac os
    if [[ $(uname -m) == "arm"* ]]; then
      version_go="go$go_version.darwin-arm64.tar.gz"
    else
      version_go="go$go_version.darwin-amd64.tar.gz"
    fi
  else
    # if linux
    if [[ $(uname -m) == "arm"* ]]; then
      version_go="go$go_version.linux-arm64.tar.gz"
    else
      version_go="go$go_version.linux-amd64.tar.gz"
    fi
  fi

  wget https://golang.org/dl/$version_go
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf $version_go
  rm $version_go
  echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.bashrc
  echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc
  echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
  echo 'export PATH=$PATH:$GOPATH/bin' >> $HOME/.bashrc
  source $HOME/.bashrc
fi

printf "${GR}Installing Celestia Node...\n${EC}"
printf "${GR}======================================================\n${EC}"
image_name=$(curl -s https://api.github.com/repos/celestiaorg/celestia-node/releases/latest | grep -oP '"tag_name": "v\K(.*)(?=")')
printf "Install latest image: $image_name\n"
docker run -e NODE_TYPE=$node_type ghcr.io/celestiaorg/celestia-node:$image_name celestia $node_type start --core.ip https://limani.celestia-devops.dev --core.grpc.port 9090 --gateway --gateway.addr 0.0.0.0 --gateway.port 26659 --p2p.network mocha

echo "
# open bash prompt in the container
docker exec -it $CONTAINER_NAME bash
"

