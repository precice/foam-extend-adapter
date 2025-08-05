#!/bin/bash
podman run --rm --name precice-fedev --volume $(pwd)/..:/home/foamuser/precice:copy  --volume $(pwd)/../../tutorials:/home/foamuser/tutorials:copy ghcr.io/hoehnp/openfoam-adapter:precice-foam-extend-dev bash -c /home/foamuser/precice/docker/install_fedev.sh 
