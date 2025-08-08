#!/bin/bash 

# shellcheck source=/dev/null
source /home/foamuser/foam/foam-extend-4.1/etc/bashrc

cd /home/foamuser/precice/ || exit
git config --global --add safe.directory /home/foamuser/precice/./.git
#git clone . ../adapter
#cd ../adapter || exit
#git checkout foam-extend-4.1
#./Allwmake

cd /home/foamuser/tutorials/quickstart || exit
rm -rf precice-run
cd solid-cpp || exit
cmake .
make

#./rigid_body_solver &
#cd ../fluid-foam-extend || exit
#blockMesh
#pimpleDyMFoam
