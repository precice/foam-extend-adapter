#!/bin/bash 

source /home/foamuser/foam/foam-extend-5.0/etc/bashrc

cd /home/foamuser/precice/
git config --global --add safe.directory /home/foamuser/precice/./.git
git clone . ../adapter
cd ../adapter
git checkout foam-extend-5.0
./Allwmake

cd /home/foamuser/tutorials/quickstart
rm -rf precice-run
cd solid-cpp
cmake .
make
./rigid_body_solver &
cd ../fluid-foam-extend
blockMesh
pimpleDyMFoam
