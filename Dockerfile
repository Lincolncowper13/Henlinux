FROM almalinux:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN yum -y update && \
    yum -y install \
    curl \
    vim \
    wget \
    nano \
    iproute \
    iputils \
    sudo \
    net-tools \
    tar \
    gzip \
    unzip \
    git \
    gnupg \
    && yum clean all
RUN curl -s https://ngrok.com/download | tar -xzv && \
    mv ngrok /usr/local/bin/ngrok
RUN useradd -m henuser && echo "henuser:password" | chpasswd && \
    usermod -aG wheel henuser
RUN echo "HOSTNAME=henlinux.local" >> /etc/sysconfig/network && \
    hostnamectl set-hostname henlinux.local
RUN echo "henuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/henuser
RUN yum -y install openssh-server && \
    systemctl enable sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]