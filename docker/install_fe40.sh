#!/bin/bash 

source /home/foamuser/foam/foam-extend-4.0/etc/bashrc

cd /home/foamuser/precice/
git config --global --add safe.directory /home/foamuser/precice/./.git
git clone . ../adapter
cd ../adapter
git checkout foam-extend-4.0
LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./Allwmake

