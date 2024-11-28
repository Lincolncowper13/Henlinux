FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install \
    curl \
    vim \
    wget \
    nano \
    iproute2 \
    iputils-ping \
    sudo \
    net-tools \
    tar \
    gzip \
    unzip \
    git \
    gnupg \
    && apt-get clean

RUN curl -s https://ngrok.com/download | tar -xzv && \
    mv ngrok /usr/local/bin/ngrok

RUN useradd -m henuser && echo "henuser:password" | chpasswd && \
    usermod -aG sudo henuser

RUN echo "HOSTNAME=henlinux.local" >> /etc/hostname && \
    hostnamectl set-hostname henlinux.local

RUN echo "henuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/henuser

RUN apt-get -y install openssh-server && \
    systemctl enable ssh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
