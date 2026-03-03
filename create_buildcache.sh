#! /bin/bash

git clone --branch spackify-fletch-support --single-branch https://gitlab.kitware.com/kwiver/kwiver
export SPACK_ROOT=$(pwd)/spack
source spack/share/spack/setup-env.sh

spack env activate ./kwiver
spack config --scope "env:$(pwd)/kwiver" add "packages:all:prefer:[target=$(spack arch --family --target)]"
spack config --scope "env:$(pwd)/kwiver" add "config:installer:new"
spack concretize
spack -v install -j 10
spack buildcache push --update-index --with-build-dependencies fletch-buildcache
