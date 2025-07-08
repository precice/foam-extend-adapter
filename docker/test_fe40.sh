#!/bin/bash
podman run --rm --name precice-fe40 --volume $(pwd)/..:/home/foamuser/precice:copy --volume $(pwd)/../../tutorials:/home/foamuser/tutorials:copy  ghcr.io/hoehnp/openfoam-adapter:precice-foam-extend-4.0 bash -c /home/foamuser/precice/docker/install_fe40.sh 
