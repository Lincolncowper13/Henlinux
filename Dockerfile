FROM debian:bullseye

# Update dan install paket yang diperlukan
RUN apt-get update && apt-get install -y \
  openssh-server \
  curl \
  gnupg \
  tailscale \
  && apt-get clean

# Membuat direktori untuk ssh
RUN mkdir /var/run/sshd

# Set environment variable
ENV DEBIAN_FRONTEND=noninteractive

# Expose port untuk SSH
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
