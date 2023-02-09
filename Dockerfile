ARG BUILDER_TAG=2b4a7c74c0b1c44d4da35bd73d079783d6e8e636-4138665917-1
ARG SHIM_TAG=ipxe-15.7

#
# Build binaries
#

FROM docker.io/ipxe/shimbuilder:${BUILDER_TAG} AS build-only

ARG SHIM_TAG

RUN git clone --depth 1 --recurse-submodules --shallow-submodules \
    https://github.com/ipxe/shim --branch ${SHIM_TAG}

RUN mkdir shim/build-{x64,aa64}

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

RUN sha256sum /{built,submitted}/shim{x64,aa64}.efi | sort -t / -k 3

RUN cmp /{built,submitted}/shimx64.efi

RUN cmp /{built,submitted}/shimaa64.efi
