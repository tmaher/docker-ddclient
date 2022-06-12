FROM alpine

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    bzip2 \
    gcc \
    make \
    tar \
    wget && \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    bind-tools \
    curl \
    inotify-tools \
    jq \
    perl \
    perl-digest-sha1 \
    perl-io-socket-inet6 \
    perl-io-socket-ssl \
    perl-json && \
    perl-io-socket-inet6 \
    curl -L -o /tmp/ddclient.tgz \
        https://github.com/ddclient/ddclient/archive/refs/tags/v3.10.0_2.tar.gz && \
    cd /tmp && \
    tar zxf ddclient.tgz && \
    cd v3.10.0_2 && \
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc/ddclient \
        --localstatedir=/var && \
    make && \ 
    make VERBOSE=1 check && \
    make install
    
    VOLUME /config