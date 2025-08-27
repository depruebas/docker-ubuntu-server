# Use Ubuntu 24.04 as base image
FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

ARG UID

RUN if id -u ${UID} >/dev/null 2>&1; then \
    userdel $(id -un ${UID}); \
    fi 

RUN useradd -u ${UID} -m -s /bin/bash devuser

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and install basic packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    nano \
    vim \
    net-tools \
    iputils-ping \
    systemd \
    sudo \
    iproute2 iputils-ping locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# RUN echo "StrictHostKeyChecking no" >> /home/devuser/.ssh/config

RUN locale-gen es_ES.UTF-8
RUN echo 'echo "LANG=es_ES" > /etc/default/locale'
ENV LC_ALL=es_ES.UTF-8

RUN adduser devuser sudo
RUN adduser devuser adm

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set working directory
WORKDIR /home/devuser

# Default command (optional)
CMD ["/bin/bash"]
