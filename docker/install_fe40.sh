#!/bin/bash 

source /home/foamuser/foam/foam-extend-4.0/etc/bashrc

cd /home/foamuser/precice/
git config --global --add safe.directory /home/foamuser/precice/./.git
git clone . ../adapter
cd ../adapter
git checkout foam-extend-4.0
alias g++="g++ -std=c++11"
LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./Allwmake
cd /home/foamuser/adapter 
LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH SOURCE=CHT/HeatFlux_incompressible.C ;  /usr/local/bin/g++ -std=c++11 -m64 -Dlinux64 -DWM_DP -Wall -Wextra -Wno-unused-parameter -Wold-style-cast -Wnon-virtual-dtor -O3  -DNoRepository -ftemplate-depth-200 -I/home/foamuser/foam/foam-extend-4.0/src/finiteVolume/lnInclude     -I/home/foamuser/foam/foam-extend-4.0/src/meshTools/lnInclude     -I/home/foamuser/foam/foam-extend-4.0/src/transportModels/     -I/home/foamuser/foam/foam-extend-4.0/src/transportModels/incompressible/lnInclude     -I/home/foamuser/foam/foam-extend-4.0/src/transportModels/compressible/lnInclude     -I/home/foamuser/foam/foam-extend-4.0/src/transportModels/twoPhaseMixture/lnInclude     -I/home/foamuser/foam/foam-extend-4.0/src/transportModels/interfaceProperties/lnInclude     -I/home/foamuser/foam/foam-extend-4.0/src/thermophysicalModels/basic/lnInclude     -I/home/foamuser/foam/foam-extend-4.0/src/turbulenceModels/     -I/home/foamuser/foam/foam-extend-4.0/src/triSurface/lnInclude          -I../      -IlnInclude -I. -I/home/foamuser/foam/foam-extend-4.0/src/foam/lnInclude -I/home/foamuser/foam/foam-extend-4.0/src/OSspecific/POSIX/lnInclude   -fPIC -c $SOURCE -o Make/linux64GccDPOpt/HeatFlux_incompressible.o

