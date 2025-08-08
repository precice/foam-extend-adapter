FROM ubuntu:22.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git binutils-dev cmake flex zlib1g-dev libncurses5-dev curl bison libxt-dev rpm mercurial graphviz openmpi-bin libopenmpi-dev build-essential linux-generic libmpich-dev libopenmpi-dev metis  libmetis-dev libparmetis-dev scotch libscotch-dev python3 python3-dev python-is-python3 python3-setuptools mercurial wget sudo pkg-config

RUN wget https://github.com/precice/precice/releases/download/v3.1.1/libprecice3_3.1.1_jammy.deb
RUN DEBIAN_FRONTEND=noninteractive apt install -y ./libprecice3_3.1.1_jammy.deb

RUN useradd -m foamuser
RUN chown foamuser:foamuser /home/foamuser
USER foamuser
WORKDIR /home/foamuser
RUN mkdir foam

WORKDIR /home/foamuser/foam
RUN git clone git://git.code.sf.net/p/foam-extend/foam-extend-5.0 foam-extend-5.0

WORKDIR /home/foamuser/foam/foam-extend-5.0
RUN sed -i -e 's=rpmbuild --define=rpmbuild --define "_build_id_links none" --define=' ThirdParty/tools/makeThirdPartyFunctionsForRPM
RUN bash -c "source etc/bashrc;  ./Allwmake.firstInstall"

RUN echo "alias fe50='source \$HOME/foam/foam-extend-5.0/etc/bashrc'" >> $HOME/.bashrc

WORKDIR /home/foamuser
RUN git clone https://github.com/hoehnp/tutorials
WORKDIR /home/foamuser/tutorials/quickstart/solid-cpp
RUN git checkout add_foam_extend_tutorial
RUN bash -c "cmake . ; make" 

