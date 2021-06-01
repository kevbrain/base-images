FROM registry.access.redhat.com/ubi8/ubi-minimal

USER root


RUN microdnf --setopt=tsflags=nodocs install -y java-11-openjdk-devel \
            && microdnf clean all \
            && rpm -q java-11-openjdk-devel
            
ENV \
            JAVA_HOME="/usr/lib/jvm/java-11" \
            JAVA_VENDOR="openjdk" \
            JAVA_VERSION="11" 

RUN mkdir /app
WORKDIR /app/

# Tricks to set time correctly
ENV TZ=Europe/Brussels
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD ca-cert/*.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

USER 1000
