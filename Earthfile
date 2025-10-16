VERSION 0.8

FROM scratch
USER root

generator:
    ARG libc

    FROM docker.io/xgqt/ci-gentoo-tools:3.0.0.current-${libc}
    WORKDIR /earthly/

    COPY --dir builder .
    RUN make -C builder

    COPY --dir generator .
    RUN make -C generator

    SAVE ARTIFACT ./generator/dotnet-sdk-* AS LOCAL ./artifacts/

build:
    BUILD +generator --libc=glibc --libc=musl
