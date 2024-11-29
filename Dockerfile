# Gunakan image dasar Debian
FROM debian:bullseye-slim

# Menambahkan repositori Tailscale
RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/bullseye.gpg | tee /etc/apt/trusted.gpg.d/tailscale.asc
RUN echo "deb https://pkgs.tailscale.com/stable/ubuntu bullseye main" | tee /etc/apt/sources.list.d/tailscale.list

# Memperbarui repositori dan menginstal paket yang diperlukan
RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    tailscale \
    && apt-get clean

# Menambahkan konfigurasi SSH untuk akses root
RUN mkdir /var/run/sshd
RUN echo 'root:Henlinux13' | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Menjalankan SSH dan Tailscale
CMD service ssh start && tailscale up --auth-key ${TAILSCALE_AUTHKEY} && tail -f /dev/null
