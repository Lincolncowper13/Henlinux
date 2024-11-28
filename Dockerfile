FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
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

# Install ngrok
RUN curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip && \
    unzip ngrok.zip && \
    mv ngrok /usr/local/bin/ngrok && \
    rm ngrok.zip

# Create user and setup SSH
RUN useradd -m henuser && echo "henuser:Henlinux" | chpasswd && \
    usermod -aG sudo henuser

# Set hostname by editing /etc/hostname and /etc/hosts
RUN echo "henlinux.local" > /etc/hostname && \
    echo "127.0.0.1   henlinux.local" >> /etc/hosts

RUN echo "henuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/henuser

RUN apt-get -y install openssh-server && \
    systemctl enable ssh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
