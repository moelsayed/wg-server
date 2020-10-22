#!/bin/bash

# I just started, I am not ready yet!
rm -rf /wg/.ready
# Install. We need to do this becasue it depends on the host kernel version.
DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get -yy -q install wireguard-dkms wireguard-tools


# generate server keys

umask 077
wg genkey | tee server_private_key | wg pubkey > server_public_key

server_pvtkey=$(cat server_private_key)

# setup configuration

sed -e "s-SERVER_PVTKEY-${server_pvtkey}-g" wg0.conf.tpl > /etc/wireguard/wg0.conf
chown -v root:root /etc/wireguard/wg0.conf
chmod -v 600 /etc/wireguard/wg0.conf



# Configure my network, I think.. I just copied those..

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

iptables -A INPUT -p udp -m udp --dport 51820 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -i wg0 -o wg0 -m conntrack --ctstate NEW -j ACCEPT

iptables -t nat -A POSTROUTING -s 10.200.200.0/24 -o eth0 -j MASQUERADE

# start the insterface
wg-quick up wg0

# alright, if I mad it this far, it should be ok
touch /wg/.ready

/usr/games/cowsay -f dragon "So, here we are.. the thing is, wireguard runs in kernel space, \
at this point, I am basically a \"sleep infinity\" command running.. \
I am just here to look pretty and let you run the add_client script.. "

# all should be good now ? let's sleep!
sleep infinity
