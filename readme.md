```
Docker Image for Action Source Dedicated Server
Action Dedicated Server - appid 985050
Action Client Files(can be used to create sdk2013 server) - 977050
Source SDK2013 - appid 244310

#./steamcmd.sh +login <user> +force_install_dir /root/actionsource/ +app_set_config 977050 +app_update 977050 +quit
#./steamcmd.sh +login <user> +force_install_dir /root/ahls/ +app_update 985050 +quit
#./steamcmd.sh +login <user> +force_install_dir /root/ahls/ +app_update 244310 +quit

# cp /root/steam/linux32/steamclient.so /root/.steam/sdk32/

Required files: ahl2 directory
Optional Required files: souce sdk2013 

docker-compose.yml example

version: '3'
services:
  hlds:
    image: unbalancedmind/actionsource
    ports:
      - "27000-27050:27000-27050/tcp"
      - "27000-27050:27000-27050/udp"
      - "1200:1200/udp"
      - "26900:26900/udp"
    volumes:
      - "./config/server.cfg:/root/sourcesdk2k13/ahl2/cfg/server.cfg"


Server/Host Setup(ubuntu 16.04 lts):

# Get docker + tools
curl -fsSL https://get.docker.com | sh
systemctl enable docker
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
curl -L https://github.com/andreaskoch/dcsg/releases/download/v0.4.0/dcsg_linux_amd64 > /usr/local/bin/dcsg
chmod +x /usr/local/bin/dcsg
# install compose file as systemd service
cd /root/actionsource && dcsg intstall docker-compose.yml
```