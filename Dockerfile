FROM jenkins/jenkins:latest

RUN mkdir -p /tmp/downloads

# install go
USER root
RUN curl -sf -o /tmp/downloads/go1.11.5.linux-amd64.tar.gz -L https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz
RUN mkdir -p /opt && cd /opt && tar xfz /tmp/downloads/go1.11.5.linux-amd64.tar.gz
RUN rm -rf /tmp/downloads/go1.11.5.linux-amd64.tar.gz
ENV GOROOT /opt/go
ENV GOPATH /opt/gocode
ENV PATH="/opt/go/bin:/opt/gocode/bin:${PATH}"

# switch back to jenkins user
USER jenkins

ADD version.txt /etc
