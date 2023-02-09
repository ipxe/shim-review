#!/bin/bash

set -x
set -e
set -o pipefail

# Run build to generate binaries
#
podman build . -t ipxe-review --no-cache -v $(pwd):/built --target build-only

# Rerun build to verify binaries and generate build log
#
podman build . -t ipxe-review --no-cache --progress=plain 2>&1 | tee build.log
