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
    openssh-server \
    && apt-get clean

# Install ngrok
RUN curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip && \
    unzip ngrok.zip && \
    mv ngrok /usr/local/bin/ngrok && \
    rm ngrok.zip

# Create user and setup SSH
RUN useradd -m henuser && echo "henuser:password" | chpasswd && \
    usermod -aG sudo henuser

# Set hostname in entrypoint to avoid "read-only" error
ENV HOSTNAME=henlinux.local

RUN echo "henuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/henuser

# Enable and configure SSH service
RUN mkdir /var/run/sshd

# Expose SSH port
EXPOSE 22

# Start SSH and ngrok tunnel
CMD ["bash", "-c", "echo $HOSTNAME > /etc/hostname && /usr/sbin/sshd -D & ngrok tcp 22"]
