FROM alpine

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    autoconf \
    automake \
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
  curl -L -o /tmp/ddclient.tgz \
    https://github.com/ddclient/ddclient/archive/refs/tags/v3.10.0_2.tar.gz && \
  cd /tmp && \
  tar zxf ddclient.tgz && \
  cd ddclient-3.10.0_2 && \
  ./autogen && \
  ./configure \
    --prefix=/usr \
    --sysconfdir=/config \
    --localstatedir=/config && \
  make && \
  make VERBOSE=1 check && \
  make install && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /config/.cpanm \
    /root/.cpanm \
    /tmp/*
    
VOLUME /config
