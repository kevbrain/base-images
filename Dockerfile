FROM image-registry.openshift-image-registry.svc:5000/openshift/cli:latest

USER root

RUN microdnf --setopt=tsflags=nodocs install -y maven \
            && microdnf clean all 
            
RUN mkdir /app
WORKDIR /app/

# Tricks to set time correctly
ENV TZ=Europe/Brussels
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER 1000
