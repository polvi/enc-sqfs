FROM stackbrew/ubuntu:13.04
RUN apt-get update
RUN apt-get install -y build-essential git-core wget uuid-dev libdevmapper-dev libpopt-dev libgcrypt11-dev
RUN mkdir /build
WORKDIR /build
RUN wget https://www.kernel.org/pub/linux/utils/cryptsetup/v1.6/cryptsetup-1.6.4.tar.gz
RUN tar -xzvf cryptsetup-1.6.4.tar.gz
WORKDIR /build/cryptsetup-1.6.4
RUN ./configure
RUN make install
ADD enc-sqfs.sh /usr/bin/enc-sqfs.sh
RUN mkdir -p /opt/imgs
WORKDIR /opt/imgs
#ENTRYPOINT ["/usr/bin/enc-sqfs.sh"]
