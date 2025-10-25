FROM scratch AS ctx
COPY build_files /

# Base Image
FROM docker.io/archlinux/archlinux:latest

ENV DEV_DEPS="base-devel git rust whois"

ENV DRACUT_NO_XATTR=1

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=tmpfs,dst=/tmp --mount=type=tmpfs,dst=/root \
    /ctx/base-system.sh; \
    /ctx/bootables.sh; \
    /ctx/plasma.sh; \
    /ctx/plasma-setup.sh; \
    /ctx/kernel.sh; \
    /ctx/bootc-fixes.sh; \
    /ctx/services.sh; \
    bootc container lint
