FROM ubuntu:20.04


RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y git-core build-essential binutils-dev cmake flex bear zlib1g-dev libncurses5-dev libreadline-dev libxt-dev rpm mercurial graphviz python python-dev  python3 python3-dev gnuplot gnuplot-qt gnuplot-data mercurial wget sudo vim bzip2 zip

RUN wget https://github.com/precice/precice/releases/download/v3.1.1/libprecice3_3.1.1_focal.deb
RUN DEBIAN_FRONTEND=noninteractive apt install -y ./libprecice3_3.1.1_focal.deb

RUN cd /tmp && wget https://gmplib.org/download/gmp/archive/gmp-4.2.4.tar.bz2
RUN cd /tmp && bunzip2 gmp-4.2.4.tar.bz2 && tar xvf gmp-4.2.4.tar && cd gmp-4.2.4 && ./configure && make && make install
RUN cd /tmp && wget https://www.mpfr.org/mpfr-2.4.2/mpfr-2.4.2.tar.gz
RUN cd /tmp && tar xzvf mpfr-2.4.2.tar.gz && cd mpfr-2.4.2 && ./configure && make && make install 
RUN cd /tmp && wget https://www.multiprecision.org/downloads/mpc-0.8.2.tar.gz
RUN cd /tmp && tar xzvf mpc-0.8.2.tar.gz && cd mpc-0.8.2 && ./configure && make && make install
RUN mkdir -p /usr/local/x86_64-unknown-linux-gnu/ && cd /usr/local/x86_64-unknown-linux-gnu/ && ln -s ../lib/ lib  && ln -s ../include/ include && ln -s ../bin/ bin

RUN cd /tmp && wget https://ftp.gwdg.de/pub/misc/gcc/releases/gcc-5.5.0/gcc-5.5.0.tar.gz && tar xzvf gcc-5.5.0.tar.gz 
COPY sanitizer_platform_limits_posix.cc /tmp/gcc-5.5.0/libsanitizer/sanitizer_common/
COPY sanitizer_platform_limits_posix.h /tmp/gcc-5.5.0/libsanitizer/sanitizer_common/
#RUN cd /tmp && tar xzvf gcc-5.5.0.tar.gz && cd gcc-5.5.0 && sed -i '141d' libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cc && sed -i '233d' libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cc && sed -i '233i   unsigned struct_ustat_sz = 64;' libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cc && LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./configure --disable-multilib && LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH make && make install
RUN cd /tmp &&  cd gcc-5.5.0 && LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./configure --disable-multilib && LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH make && LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH make install


RUN useradd -m foamuser
RUN chown foamuser:foamuser /home/foamuser
WORKDIR /home/foamuser
USER foamuser
RUN mkdir foam

WORKDIR /home/foamuser/foam 
RUN git clone git://git.code.sf.net/p/foam-extend/foam-extend-4.0 foam-extend-4.0
WORKDIR /home/foamuser/foam/foam-extend-4.0
 
RUN echo export WM_THIRD_PARTY_USE_BISON_27=1  >> etc/prefs.sh
RUN echo "export WM_CC='/usr/local/bin/gcc'"  >> etc/prefs.sh
RUN echo "export WM_CXX='/usr/local/bin/g++'"  >> etc/prefs.sh
RUN echo "export WM_MPLIB=SYSTEMOPENMPI" >> etc/prefs.sh
 
RUN sed -i -e 's=rpmbuild --define=rpmbuild --define "_build_id_links none" --define=' ThirdParty/tools/makeThirdPartyFunctionsForRPM
RUN sed -i -e 's/gcc/\$(WM_CC)/' wmake/rules/linux64Gcc/c
RUN sed -i -e 's/g++/\$(WM_CXX)/' wmake/rules/linux64Gcc/c++
RUN sed -i -e 's,http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/,https://ftp.mcs.anl.gov/pub/pdetools/spack-pkgs/,g' ThirdParty/AllMake.stage3

RUN bash -c "source etc/bashrc; LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./Allwmake.firstInstall"

WORKDIR /home/foamuser
RUN git clone https://github.com/precice/tutorials
WORKDIR /home/foamuser/tutorials/quickstart/solid-cpp
RUN bash -c "cmake . ; make" 

