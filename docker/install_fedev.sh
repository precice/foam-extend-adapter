#!/bin/bash 

# shellcheck source=/dev/null
source /home/foamuser/foam/foam-extend-5.1/etc/bashrc

cd /home/foamuser/precice/ || exit
git config --global --add safe.directory /home/foamuser/precice/./.git
git clone . ../adapter
cd ../adapter || exit
git checkout foam-extend-dev
./Allwmake

cd /home/foamuser/tutorials/quickstart || exit
git pull
rm -rf precice-run
cd solid-cpp || exit
cmake .
make
./rigid_body_solver &
#cd ../fluid-foam-extend || exit
cd ../fluid-openfoam || exit
sed -i "s/run-openfoam/run-foam-extend/g" run.sh
mkdir constant/polyMesh
cp system/blockMeshDict constant/polyMesh

./run.sh

exit 0
