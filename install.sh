#!/bin/bash

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

. /etc/os-release
if [[ "$VERSION_ID" == "20.04" ]]; then

# Install fxServer

    # Kill fxServer if it is already running

    kill $(lsof -t -i:40120)

    # Install dependencies
    apt update -y
    apt install -y wget tar

    # Make a directory for the fxServer
    cd /root
    mkdir fxServer
    cd fxServer
    wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/5562-25984c7003de26d4a222e897a782bb1f22bebedd/fx.tar.xz
    tar -xvf fx.tar.xz

    # Run the fxServer
    ./run.sh &

# Add fxServer info to the MOTD

chmod -x /etc/update-motd.d/*

SERVERIP="ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'"

echo "[    actiniumcloud]   _______  ______
[    actiniumcloud]  |  ___\ \/ / ___|  ___ _ ____   _____ _ __
[    actiniumcloud]  | |_   \  /\___ \ / _ \ '__\ \ / / _ \ '__|
[    actiniumcloud]  |  _|  /  \ ___) |  __/ |   \ V /  __/ |
[    actiniumcloud]  |_|   /_/\_\____/ \___|_|    \_/ \___|_|
[    actiniumcloud] -------------------------------- ActiniumCloud ---
[    actiniumcloud]
[    actiniumcloud]
[    actiniumcloud]   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[    actiniumcloud]                                        
[    actiniumcloud]           Endereço do TxAdmin         
[    actiniumcloud]       http://$SERVERIP:40120/       
[    actiniumcloud]                                        
[    actiniumcloud]       O Nosso servidor de Discord:    
[    actiniumcloud]       https://discord.gg/fmkgRD3vfh   
[    actiniumcloud]                                        
[    actiniumcloud]   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" > /etc/motd

else

# Echo unsupported OS and exit
echo "Unsupported OS"
exit 1

fi