FROM 997690819742.dkr.ecr.us-east-1.amazonaws.com/serverjre:8
## Attribution: https://github.com/solsson/dockerfiles/tree/master/kafka
ENV KAFKA_VERSION=0.11.0.9999 SCALA_VERSION=2.11

ENV kafka_bin_version=2.11-$kafka_version

RUN set -x && yum install -y curl ca-certificates tar gzip hostname nc
RUN set -ex; \
    export DEBIAN_FRONTEND=noninteractive; \
    SCALA_BINARY_VERSION=$(echo $SCALA_VERSION | cut -f 1-2 -d '.'); \
    mkdir -p /opt/kafka; \
    curl -SLs "https://s3.amazonaws.com/onyx-platform-assets/kafka/kafka_2.11-0.11.0.9999.tgz" | tar -xzf - --strip-components=1 -C /opt/kafka; \
    \
    rm -rf /opt/kafka/site-docs; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

WORKDIR /opt/kafka

ADD https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.10/jmx_prometheus_javaagent-0.10.jar /opt/kafka/jmx_prometheus_javaagent.jar

RUN sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zookeeper:2181/' config/server.properties
ENTRYPOINT ["bin/kafka-server-start.sh"]
CMD ["config/server.properties"]
