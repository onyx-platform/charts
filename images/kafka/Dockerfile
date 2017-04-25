FROM java:openjdk-8-jre
## Attribution: https://github.com/solsson/dockerfiles/tree/master/kafka
ENV kafka_version=0.10.1.1
ENV scala_version=2.11.8
ENV kafka_bin_version=2.11-$kafka_version

RUN curl -SLs "http://www.scala-lang.org/files/archive/scala-$scala_version.deb" -o scala.deb \
        && dpkg -i scala.deb \
        && rm scala.deb \
        && curl -SLs "http://www-eu.apache.org/dist/kafka/$kafka_version/kafka_$kafka_bin_version.tgz" | tar -xzf - -C /opt \
        && mv /opt/kafka_$kafka_bin_version /opt/kafka

WORKDIR /opt/kafka
ENTRYPOINT ["bin/kafka-server-start.sh"]

ADD https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.9/jmx_prometheus_javaagent-0.9.jar /opt/kafka/jmx_prometheus_javaagent.jar
ADD container-limits /opt/kafka/

RUN sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zookeeper:2181/' config/server.properties
CMD ["config/server.properties"]
