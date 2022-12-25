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
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io -y

if [ ! $node_type ]; then
	read -p "Enter your NODE TYPE you want to run (light/bridge/full): " node_type
fi

# check directory Celestia-Node if not exist then clone else pull from github
if [ ! -d "$HOME/$repo_name" ]; then
  printf "${GR}Cloning Celestia-Node...\n${EC}"
  printf "${GR}======================================================\n${EC}"
  git clone https://github.com/bxdoan/Celestia-Node.git
else
  printf "${GR}Pulling Celestia-Node...\n${EC}"
  printf "${GR}======================================================\n${EC}"
  cd "$HOME/$repo_name"
  git pull
fi


printf "${GR}Installing Celestia Node...\n${EC}"
printf "${GR}======================================================\n${EC}"
cd "$HOME"
image_version=$(curl -s https://api.github.com/repos/celestiaorg/celestia-node/releases/latest | grep -oP '"tag_name": "v\K(.*)(?=")')
printf "Install latest image: $image_version\n"
docker run -e NODE_TYPE=$node_type ghcr.io/celestiaorg/celestia-node:$image_version celestia $node_type start --core.ip https://limani.celestia-devops.dev --core.grpc.port 9090 --gateway --gateway.addr 0.0.0.0 --gateway.port 26659 --p2p.network mocha
