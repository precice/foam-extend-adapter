#!/bin/bash 

source /home/foamuser/foam/foam-extend-4.1/etc/bashrc

cd /home/foamuser/precice/
git config --global --add safe.directory /home/foamuser/precice/./.git
git clone . ../adapter
cd ../adapter
git checkout foam-extend-4.1
./Allwmake
