FROM debian:bookworm

# Install all PHP compilation dependencies
RUN apt-get update && apt-get install -y \
    make \
    autoconf \
    automake \
    m4 \
    gzip \
    bzip2 \
    bison \
    g++ \
    git \
    cmake \
    pkg-config \
    re2c \
    libtool \
    libtool-bin \
    wget \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create container user (Pterodactyl standard)
RUN useradd -m -d /home/container -s /bin/bash container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
