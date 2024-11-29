# Menambahkan repositori Tailscale
RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/bullseye.gpg | tee /etc/apt/trusted.gpg.d/tailscale.asc
RUN echo "deb https://pkgs.tailscale.com/stable/ubuntu bullseye main" | tee /etc/apt/sources.list.d/tailscale.list

# Perbarui dan pasang paket
RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    gnupg \
    tailscale \
    && apt-get clean
