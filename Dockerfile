FROM jenkins/jenkins:alpine

USER root

# Update apk repositories
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Install the latest Docker and docker-compose binaries
RUN apk -U --no-cache \
    --allow-untrusted add \
    gcc \
    docker \
    make \
    curl \
    && rm -rf /var/cache/* \
    && mkdir /var/cache/apk

# allow jenkins user to access docker 
RUN addgroup jenkins docker
RUN chmod 0777 /var/run/docker.sock

# switch back to jenkins user
USER jenkins

ADD version.txt /etc
