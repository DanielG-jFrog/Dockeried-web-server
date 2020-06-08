FROM alpine:latest

RUN apk add --update bash libstdc++ curl zip && \
    rm -rf /var/cache/apk/*

FROM openjdk:8

CMD ["export", "JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/"]

RUN curl -L https://bintray.com/artifact/download/groovy/maven/apache-groovy-binary-2.4.8.zip -o /tmp/groovy.zip && \
    cd /usr/local && \
    unzip /tmp/groovy.zip && \
    rm /tmp/groovy.zip && \
    ln -s /usr/local/groovy-2.4.8 groovy && \
    /usr/local/groovy/bin/groovy -v && \
    cd /usr/local/bin && \
    ln -s /usr/local/groovy/bin/groovy groovy

ADD src/main/groovy/server.groovy /src/main/groovy/server.groovy

WORKDIR /src/main/groovy

EXPOSE 8080

ENTRYPOINT ["groovy", "server.groovy"]

