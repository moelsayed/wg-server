FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -yy -q  install \
    apt-transport-https software-properties-common iptables iproute2 curl cowsay 


RUN mkdir -p /wg/clients
ADD entry.sh  wg0.conf.tpl next_client wg0-client.conf.tpl /wg/
ADD add_client /usr/local/bin
RUN chmod +x /wg/entry.sh /usr/local/bin/add_client
WORKDIR /wg
ENTRYPOINT ["/wg/entry.sh"]
