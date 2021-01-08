FROM alpine:3.12

ENV BUILD_DEPS="bash make gcc g++ cmake curl pkgconfig perl bsd-compat-headers zlib-dev lz4-dev openssl-dev curl-dev"
ENV RUN_DEPS="libcurl lz4-libs ca-certificates"

RUN apk add --no-cache git bash
RUN git clone https://github.com/edenhill/kafkacat.git /usr/src/kafkacat

RUN \
    echo Installing ; \
    apk add --no-cache --virtual .dev_pkgs $BUILD_DEPS $BUILD_DEPS_EXTRA \
    && apk add --no-cache $RUN_DEPS $RUN_DEPS_EXTRA \
    && echo Building \
    && cd /usr/src/kafkacat \
    && rm -rf tmp-bootstrap \
    && echo "Source versions:" \
    && grep ^github_download ./bootstrap.sh \
    && ./bootstrap.sh \
    && mv kafkacat /usr/bin/ ; \
    echo Cleaning up ; \
    cd / ; \
    rm -rf /usr/src/kafkacat; \
    apk del .dev_pkgs ; \
    rm -rf /var/cache/apk/*

ADD ./entrypoint.sh /entrypoint.sh
ADD ./kafka.config /kafka.config

ENTRYPOINT ["/entrypoint.sh"]
