FROM ubuntu:20.04

# Update system and add the packages required for Yocto builds.
# Use DEBIAN_FRONTEND=noninteractive, to avoid image build hang waiting
# for a default confirmation [Y/n] at some configurations.

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update

RUN apt install -y diffstat xmlstarlet texinfo chrpath gcc-aarch64-linux-gnu libarchive-dev ssh \
	libselinux1-dev fakechroot g++-aarch64-linux-gnu libiberty-dev qemu-user-static g++ gawk gcc make \
	libwayland-dev fakeroot libpam0g-dev openjdk-8-jdk-headless binutils-dev util-linux uuid-dev zstd \
	libncurses5 \
	gawk wget git-core diffstat unzip texinfo \
    chrpath socat cpio python python3 \
    python3-pip python3-pexpect xz-utils debianutils iputils-ping \
    libsdl1.2-dev xterm tar locales net-tools rsync sudo vim curl zstd \
    liblz4-tool libssl-dev bc lzop libxml2-utils binutils libxml-simple-perl

RUN sudo rm -rf /lib/ld-linux-aarch64.so.1
RUN sudo ln -sf /usr/aarch64-linux-gnu/lib/ld-2.31.so /lib/ld-linux-aarch64.so.1
RUN sudo ln -sf /bin/bash /bin/sh
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/q/qemu/qemu-user-static_6.2+dfsg-2ubuntu6_amd64.deb
RUN sudo dpkg -i qemu-user-static_6.2+dfsg-2ubuntu6_amd64.deb


# Set up locales
RUN locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Yocto needs 'source' command for setting up the build environment, so replace
# the 'sh' alias to 'bash' instead of 'dash'.
RUN rm /bin/sh && ln -s bash /bin/sh




# Install repo
ADD https://storage.googleapis.com/git-repo-downloads/repo /usr/local/bin/
RUN chmod 755 /usr/local/bin/repo

# Add your user to sudoers to be able to install other packages in the container.
ARG USER
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER}

# Set the arguments for host_id and user_id to be able to save the build artifacts
# outside the container, on host directories, as docker volumes.
ARG host_uid \
    host_gid
RUN groupadd -g $host_gid DOCKER_GROUP && \
    useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER

# Yocto builds should run as a normal user.
USER $USER

ARG DOCKER_WORKDIR
WORKDIR ${DOCKER_WORKDIR}

COPY copy/.bashrc /home/$USER

ENV TZ=Asia/Seoul
RUN sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime





