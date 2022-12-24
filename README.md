<h1 align="center"> Celestia Node BXDOAN

## If you don't want to having problems with claim for a possible Celestia airdrop, this guide is for you. Do not forget to star and fork from the top right. If you have questions: [Chat](https://t.me/bxdoan)


## System Requirements:
NODE TYPE | CPU | RAM | SSD     | Bandwidth
| ------------- |-----|-----| -------- | -------- |
| Mainnet | 4   | 8   | 400-500  | 1 Gbps for Download/100 Mbps for Upload


[here](https://docs.celestia.org/developers/node-tutorial) for more information

## Install the Celestia node.

### Open a screen.
Install screen if you don't have it.

Linux:
```sh
sudo apt install screen -y
```

macOS
```sh
brew install screen -y
```

open a screen
```sh
screen -S celestia
```

### Scripted installation.


```
wget -O celestia.sh https://raw.githubusercontent.com/bxdoan/Celestia-Node/main/celestia.sh && chmod +x celestia.sh && ./celestia.sh
```

you will see something like this and type your node type you want to run (full, bridge or light):
![image](./imgs/choose_type_node.png)

The result will be like this:
![image](https://docs.celestia.org/assets/images/mocha_light_docker-47b10985b0784499df40395e28023537.gif)

Run `docker ps` to show docker container name:
![image](./imgs/docker_ps.png)

## Backup your wallet and keys.

Go to inside docker container by using command, replace `<container_name>` by `angry_northcutt` in this case:
```sh
docker exec -it <container_name> bash
```

Run this command to show your wallet and keys, then backup it:
```sh
./cel-key list --node.type <node_type> --keyring-backend test
```

## Contact
[Telegram](https://t.me/bxdoan)

[Email](mailto:hi@bxdoan.com)

## Thanks for use
Buy me a coffee

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/bxdoan)
