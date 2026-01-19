FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Only lightweight core system packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    # Core networking & system tools
    ca-certificates \
    curl \
    wget \
    dnsutils \
    net-tools \
    iproute2 \
    zip \
    unzip \
    # Monitoring & viewing
    htop \
    jq \
    less \
    tree \
    tcpdump \
    # Build essentials
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set timezone
ENV TZ=America/Phoenix

RUN echo "✅ Base system ready"

