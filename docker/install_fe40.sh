#!/bin/bash 

# shellcheck source=/dev/null
source /home/foamuser/foam/foam-extend-4.0/etc/bashrc

cd /home/foamuser/precice/ || exit
git config --global --add safe.directory /home/foamuser/precice/./.git
git clone . ../adapter
cd ../adapter || exit
git checkout foam-extend-4.0
LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./Allwmake

cd /home/foamuser/tutorials/quickstart || exit
rm -rf precice-run
cd solid-cpp || exit
LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH cmake .
LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH make
./rigid-body-solver &
cd ../fluid-foam-extend || exit
pimpleDyMFoam

exit 0
