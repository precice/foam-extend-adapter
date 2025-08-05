#!/bin/bash

for version in 4.0 4.1 5.0 dev
#for version in 4.1
do
	echo "building versioni fe-$version"
	cd fe-$version
	podman build -t=ghcr.io/hoehnp/openfoam-adapter:precice-foam-extend-$version . 
	podman push ghcr.io/hoehnp/openfoam-adapter:precice-foam-extend-$version
	cd ..
done
