FROM scratch AS ctx

COPY build_files /
FROM ghcr.io/ublue-os/brew AS brew

FROM quay.io/centos-bootc/centos-bootc:stream10

COPY system_files /
COPY cosign.pub /etc/pki/containers/horizonlinux.pub
COPY --from=brew /system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/01-setupdnf.sh && \
    /ctx/02-basesystem.sh && \
    /ctx/03-KDE.sh && \
    /ctxs/04-includebatteries.sh && \
    /ctx/05-systemconf.sh && \
    /ctx/06-fixdirs.sh && \
    /ctx/07-initramfs.sh

RUN bootc container lint
