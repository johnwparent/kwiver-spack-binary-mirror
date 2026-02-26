ARG BASE_IMAGE=ghcr.io/spack/manylinux2014:v2024-10-16
FROM ${BASE_IMAGE}

ARG PYTHON_VERSION

WORKDIR /root
ENV PATH="/root/spack/bin/:$PATH" \
    SPACK_BACKTRACE=please \
    SPACK_COLOR=always \
    SPACK_PYTHON=/opt/python/cp311-cp311/bin/python \
    PYTHONUNBUFFERED=1

RUN mkdir /root/spack && \
    cd /root/spack && \
    git init . && \
    git fetch --depth=1 https://github.com/spack/spack.git 2e2169d5282d166f63e3ee4db8d4446c43cefa8a:v1.1.1 && \
    git checkout v1.1.1

RUN mkdir /root/spack-packages && \
    cd /root/spack-packages && \
    git init . && \
    git fetch --depth=1 https://github.com/spack/spack-packages.git 45b96ec41203e91909116589197f3876f9107358:v2026-2-26 && \
    git checkout v2026-2-26

RUN spack repo set --destination /root/spack-packages builtin
RUN spack config add "config:install_tree:padded_length:256"

