# Dockerized Wireguard setup

**Caution:** This is just a PoC. It's not really tested that much, there is no error checking or validation and defaults are used whenever possible. Use at your own risk.


##### Requirements
- You need a Linux server running docker _(ProTip: Try this with docker-machine ? You don't even need to ssh to the server!)_:
  - Ubuntu 16.04 was supported until `0.0.20190905-wg1~xenial` accidentally the whole thing.
  - Updated to 18.04.
- You need to [install Wireguard](https://www.wireguard.com/install/) on your machine.  


##### Usage:

- Run this container on your Linux server:

```bash
docker run -d --name wg-server \
--sysctl="net.ipv4.ip_forward=1" \
--cap-add NET_ADMIN --cap-add SYS_MODULE \
-v /lib/modules/:/lib/modules/ -p 51833:51833/udp melsayed/wg-server:18.04
```
- Wait for a couple of minutes until the kernel module is deployed.
- Run the following command on your linux server, to get client config:
```
docker exec wg-server add_client <client name>
```

That's it! Use the generated configuration to connect to the server!
