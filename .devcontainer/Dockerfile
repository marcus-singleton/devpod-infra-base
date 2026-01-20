FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=America/Phoenix

# Install essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    openssh-client \
    bash \
    bash-completion \
    sudo \
    procps \
    jq \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Remove ubuntu user if exists, create dev user
RUN userdel -r ubuntu 2>/dev/null || true && \
    groupdel ubuntu 2>/dev/null || true && \
    groupadd --gid 1000 dev && \
    useradd --uid 1000 --gid 1000 -m -s /bin/bash dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev

# Disable root login
RUN passwd -l root

USER dev
WORKDIR /workspaces

LABEL maintainer="marcus-singleton" \
      description="DevLab development workspace"

