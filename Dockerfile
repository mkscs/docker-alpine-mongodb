FROM alpine:3.2
MAINTAINER mkscsy@gmail.com

ENV MONGODB_VERSION 3.2.0


RUN apk --update add curl libgcc libstdc++ && \
    cd /tmp && \
    curl -SLo- https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${MONGODB_VERSION}.tgz | \
    tar xz && \
    curl -SLO https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk && \
    curl -SLO https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk && \
    apk add --allow-untrusted glibc-2.21-r2.apk glibc-bin-2.21-r2.apk && \
    /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
    mv mongodb-linux-x86_64-${MONGODB_VERSION}/bin/* /usr/bin/ && \
    apk del curl && \
    rm -rf /tmp/* /var/cache/apk/* 

ADD scripts /scripts
RUN chmod +x /scripts/*.sh && \
    touch /.initialize

ENTRYPOINT ["/scripts/run.sh"]
CMD [""]

EXPOSE 27017

VOLUME ["/data/db"]