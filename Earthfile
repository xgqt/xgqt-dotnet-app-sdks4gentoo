VERSION 0.8

FROM scratch
USER root

generic-builder-glibc:
    FROM docker.io/xgqt/ci-gentoo-tools:3.0.0.current-glibc
    WORKDIR /earthly/

    COPY --dir generic-builder .
    RUN make -C generic-builder

generic-builder-musl:
    FROM docker.io/xgqt/ci-gentoo-tools:3.0.0.current-musl
    WORKDIR /earthly/

    COPY --dir generic-builder .
    RUN make -C generic-builder

sdk-generator:
    ARG libc
    FROM +generic-builder-${libc}

    COPY --dir sdk-generator .
    RUN make -C sdk-generator

    SAVE ARTIFACT ./sdk-generator/dotnet-sdk-* AS LOCAL ./artifacts/

sdk-generate:
    BUILD +sdk-generator --libc=glibc --libc=musl

pwsh-generate:
    FROM +generic-builder-glibc

    COPY --dir pwsh-generator .
    RUN make -C pwsh-generator

    SAVE ARTIFACT ./pwsh-generator/pwsh-* AS LOCAL ./artifacts/

build:
    BUILD +sdk-generate
    BUILD +pwsh-generate    
