# Dockerized Wireguard setup

**Caution:** This is just a PoC. It's not really tested that much, there is no error checking or validation and defaults are used whenever possible. Use at your own risk.


##### Requirements
- You need a Linux server running docker. Currently, only Ubuntu 16.04 is supported. _(ProTip: Try this with docker-machine ? You don't even need to ssh to the server!)_
- You need to [install Wireguard](https://www.wireguard.com/install/) on your machine.  


##### Usage:

- Run this container on your Linux server:
```
docker run -d --name wg-server \
--sysctl="net.ipv4.ip_forward=1" \
--cap-add NET_ADMIN --cap-add SYS_MODULE \
-v /lib/modules/:/lib/modules/ -p 51820:51820/udp melsayed/wg-server
```
- Wait for a couple of minutes until the kernel module is deployed.
- Run the following command on your linux server, to get client config:
```
docker exec wg-server add_client <client name>
```

That's it! Using the generated configuration to run connect to the server!
