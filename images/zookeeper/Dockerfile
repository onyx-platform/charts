FROM 997690819742.dkr.ecr.us-east-1.amazonaws.com/serverjre:8

ENV ZK_USER=zookeeper \
    ZK_DATA_DIR=/var/lib/zookeeper/data \
    ZK_DATA_LOG_DIR=/var/lib/zookeeper/log \
    ZK_LOG_DIR=/var/log/zookeeper \
    SNAPSHOT_BUILD=https://s3.amazonaws.com/onyx-platform-assets/zookeeper/zookeeper-3.4.9999.tar.gz

ARG ZK_DIST=zookeeper-3.4.9999

RUN set -x && yum install -y wget tar gzip hostname nc
RUN set -x && wget -q "$SNAPSHOT_BUILD" \
    && tar -xzf "$ZK_DIST.tar.gz" -C /opt \
    && ln -s /opt/$ZK_DIST /opt/zookeeper \
    && rm -rf /opt/zookeeper/CHANGES.txt \
    /opt/zookeeper/README.txt \
    /opt/zookeeper/NOTICE.txt \
    /opt/zookeeper/CHANGES.txt \
    /opt/zookeeper/README_packaging.txt \
    /opt/zookeeper/build.xml \
    /opt/zookeeper/config \
    /opt/zookeeper/contrib \
    /opt/zookeeper/dist-maven \
    /opt/zookeeper/docs \
    /opt/zookeeper/ivy.xml \
    /opt/zookeeper/ivysettings.xml \
    /opt/zookeeper/recipes \
    /opt/zookeeper/src \
    /opt/zookeeper/$ZK_DIST.jar.asc \
    /opt/zookeeper/$ZK_DIST.jar.md5 \
    /opt/zookeeper/$ZK_DIST.jar.sha1 \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration generator script to bin
COPY zkGenConfig.sh zkOk.sh zkMetrics.sh /opt/zookeeper/bin/
RUN set -x \
    && useradd $ZK_USER \
    && [ `id -u $ZK_USER` -eq 1000 ] \
    && [ `id -g $ZK_USER` -eq 1000 ] \
    && mkdir -p $ZK_DATA_DIR $ZK_DATA_LOG_DIR $ZK_LOG_DIR /usr/share/zookeeper /tmp/zookeeper /usr/etc/ \
    && chown -R "$ZK_USER:$ZK_USER" /opt/$ZK_DIST $ZK_DATA_DIR $ZK_LOG_DIR $ZK_DATA_LOG_DIR /tmp/zookeeper \
    && ln -s /opt/zookeeper/conf/ /usr/etc/zookeeper \
    && ln -s /opt/zookeeper/bin/* /usr/bin \
    && ln -s /opt/zookeeper/$ZK_DIST.jar /usr/share/zookeeper/ \
    && ln -s /opt/zookeeper/lib/* /usr/share/zookeeper
