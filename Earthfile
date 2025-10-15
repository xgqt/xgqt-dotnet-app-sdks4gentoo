VERSION 0.8

# FROM docker.io/gentoo/stage3:20251015
FROM docker.io/xgqt/ci-gentoo-tools:latest

USER root
WORKDIR /earthly/

# portage:
#     FROM docker.io/gentoo/portage:20251015
#     SAVE ARTIFACT ./*

# gentoo:
#     FROM +base
#     RUN mkdir -p /var/db/repos
#     COPY --dir +portage/var/db/repos/gentoo /var/db/repos/
#     RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
#         && locale-gen \
#         && eselect locale set en_US.UTF-8
#     RUN eselect news read all >/dev/null
#     RUN getuto
#     RUN env EMERGE_DEFAULT_OPTS="--binpkg-respect-use=y --nospinner -j 2 -gnv" \
#         USE="-perl" emerge dev-vcs/git

builder:
    # FROM +gentoo
    FROM +base
    COPY --dir builder .
    RUN make -C builder

generator:
    FROM +builder
    COPY --dir generator .
    RUN make -C generator
    SAVE ARTIFACT ./generator/dotnet-sdk-* AS LOCAL ./artifacts/
