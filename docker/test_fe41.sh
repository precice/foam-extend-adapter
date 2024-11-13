#!/bin/bash
podman run --rm --name precice-fe41 --volume $(pwd)/..:/home/foamuser/precice:copy  ghcr.io/hoehnp/openfoam-adapter:precice-foam-extend-4.1 bash -c /home/foamuser/precice/docker/install_fe41.sh 
