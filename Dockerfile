ARG UBUNTU_TAG=jammy
ARG SHIM_TAG=ipxe-15.8

#
# Install build toolchain
#
# Use an Ubuntu LTS release with updates disabled so that the build is
# reproducible.
#

FROM ubuntu:${UBUNTU_TAG} AS toolchain

RUN sed -i -E 's/^(deb .*-updates)/#\1/' /etc/apt/sources.list

RUN apt update -y

RUN apt install -y build-essential dos2unix gcc-aarch64-linux-gnu git

#
# Build binaries
#

FROM toolchain AS build-only

ARG SHIM_TAG

RUN git clone --depth 1 --recurse-submodules --shallow-submodules \
    https://github.com/ipxe/shim --branch ${SHIM_TAG}

RUN mkdir shim/build-x64 shim/build-aa64

RUN make -C shim/build-x64 -f ../Makefile TOPDIR=..

RUN make -C shim/build-aa64 -f ../Makefile TOPDIR=.. \
    CROSS_COMPILE=aarch64-linux-gnu-

RUN mkdir -p /built

RUN cp -f shim/build-*/shim*.efi /built/

#
# Verify binaries match those being submitted
#

FROM build-only AS build-and-verify

RUN mkdir -p /submitted

COPY shimx64.efi shimaa64.efi /submitted/

RUN sha256sum built/shim*.efi submitted/shim*.efi | sort -t / -k 3

RUN cmp /built/shimx64.efi /submitted/shimx64.efi

RUN cmp /built/shimaa64.efi /submitted/shimaa64.efi
