#!/bin/bash
podman run --rm --name precice-fe50 --volume $(pwd)/..:/home/foamuser/precice:bind  ghcr.io/hoehnp/openfoam-adapter:precice-foam-extend-5.0 bash -c /home/foamuser/precice/docker/install_fe50.sh
