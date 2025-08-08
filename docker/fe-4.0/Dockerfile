FROM ubuntu:20.04


RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y git-core build-essential binutils-dev cmake flex bear zlib1g-dev libncurses5-dev libreadline-dev libxt-dev rpm mercurial graphviz python python-dev  python3 python3-dev gnuplot gnuplot-qt gnuplot-data mercurial wget sudo vim bzip2 zip gcc-7 g++-7

RUN wget https://github.com/precice/precice/releases/download/v3.1.1/libprecice3_3.1.1_focal.deb
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install -y ./libprecice3_3.1.1_focal.deb

RUN useradd -m foamuser
RUN chown foamuser:foamuser /home/foamuser
USER foamuser
WORKDIR /home/foamuser

RUN mkdir foam
WORKDIR /home/foamuser/foam
RUN git clone git://git.code.sf.net/p/foam-extend/foam-extend-4.0 foam-extend-4.0
WORKDIR /home/foamuser/foam/foam-extend-4.0
RUN echo export WM_THIRD_PARTY_USE_BISON_27=1  >> etc/prefs.sh
RUN echo "export WM_CC='gcc-7'"  >> etc/prefs.sh
RUN echo "export WM_CXX='g++-7'"  >> etc/prefs.sh
RUN echo "export WM_MPLIB=SYSTEMOPENMPI" >> etc/prefs.sh
 
RUN sed -i -e 's=rpmbuild --define=rpmbuild --define "_build_id_links none" --define=' ThirdParty/tools/makeThirdPartyFunctionsForRPM
RUN sed -i -e 's/gcc/\$(WM_CC)/' wmake/rules/linux64Gcc/c
RUN sed -i -e 's/g++/\$(WM_CXX)/' wmake/rules/linux64Gcc/c++
RUN sed -i -e 's,http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/,https://ftp.mcs.anl.gov/pub/pdetools/spack-pkgs/,g' ThirdParty/AllMake.stage3

RUN bash -c 'source etc/bashrc; ./Allwmake.firstInstall'

WORKDIR /home/foamuser
RUN git clone https://github.com/hoehnp/tutorials
WORKDIR /home/foamuser/tutorials/quickstart/solid-cpp
RUN git checkout add_foam_extend_tutorial
RUN bash -c "cmake . ; make" 

