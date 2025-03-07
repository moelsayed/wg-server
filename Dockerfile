FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -yy -q  install \
    binutils sed cpp cpp-5 dkms fakeroot gcc gcc-5 kmod libasan2 libatomic1 \
    libc-dev-bin libc6-dev libcc1-0 libcilkrts5 libfakeroot libgcc-5-dev \
    libgomp1 libisl15 libitm1 liblsan0 libmpc3 libmpx0 libquadmath0 \
    libtsan0 libubsan0 linux-libc-dev make manpages manpages-dev menu patch \
    apt-transport-https software-properties-common iptables iproute2 curl cowsay


RUN mkdir -p /wg/clients
ADD entry.sh  wg0.conf.tpl next_client wg0-client.conf.tpl /wg/
ADD add_client /usr/local/bin
RUN chmod +x /wg/entry.sh /usr/local/bin/add_client
WORKDIR /wg
ENTRYPOINT ["/wg/entry.sh"]
