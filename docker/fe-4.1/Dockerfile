FROM ubuntu:20.04


RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git-core build-essential binutils-dev cmake flex zlib1g-dev libncurses5-dev curl bison libxt-dev rpm mercurial graphviz python python-dev  gcc-7 g++-7 mercurial wget sudo pkg-config

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libopenmpi-dev openmpi-bin libxml2-dev

RUN cd /opt && wget https://github.com/Kitware/CMake/releases/download/v3.30.5/cmake-3.30.5-linux-x86_64.tar.gz \
    && tar xzf cmake-3.30.5-linux-x86_64.tar.gz
ENV PATH="/opt/cmake-3.30.5-linux-x86_64/bin:${PATH}"

RUN git clone --branch 3.4.0 --depth 1 https://gitlab.com/libeigen/eigen.git /tmp/eigen \
    && cmake -S /tmp/eigen -B /tmp/eigen/build -DCMAKE_INSTALL_PREFIX=/opt/eigen-3.4.0 -DEIGEN_BUILD_DOC=OFF -DBUILD_TESTING=OFF \
    && cmake --install /tmp/eigen/build

RUN cd /tmp && wget https://archives.boost.io/release/1.81.0/source/boost_1_81_0.tar.gz \
    && tar xzf boost_1_81_0.tar.gz && cd boost_1_81_0 \
    && ./bootstrap.sh --prefix=/opt/boost-1.81.0 --with-libraries=log,thread,system,filesystem,program_options,test \
    && ./b2 install -j"$(nproc)" link=shared threading=multi runtime-link=shared variant=release

RUN git clone --branch v3.4.1 --depth 1 https://github.com/precice/precice.git /tmp/precice \
    && cmake -S /tmp/precice -B /tmp/precice/build \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/opt/precice-3.4.1 \
        -DCMAKE_PREFIX_PATH="/opt/eigen-3.4.0;/opt/boost-1.81.0" \
        -DBOOST_ROOT=/opt/boost-1.81.0 \
        -DPRECICE_FEATURE_PYTHON_ACTIONS=OFF \
        -DPRECICE_FEATURE_PETSC_MAPPING=OFF \
        -DBUILD_TESTING=OFF \
        -DCMAKE_EXE_LINKER_FLAGS="-L/opt/boost-1.81.0/lib -Wl,-rpath,/opt/boost-1.81.0/lib" \
        -DCMAKE_SHARED_LINKER_FLAGS="-L/opt/boost-1.81.0/lib -Wl,-rpath,/opt/boost-1.81.0/lib" \
    && cmake --build /tmp/precice/build -j"$(nproc)" \
    && cmake --install /tmp/precice/build
ENV PKG_CONFIG_PATH="/opt/precice-3.4.1/lib/pkgconfig:/opt/precice-3.4.1/lib64/pkgconfig:${PKG_CONFIG_PATH}"
ENV LD_LIBRARY_PATH="/opt/boost-1.81.0/lib:/opt/precice-3.4.1/lib:/opt/precice-3.4.1/lib64:${LD_LIBRARY_PATH}"

RUN useradd -m foamuser
RUN chown foamuser:foamuser /home/foamuser
USER foamuser
WORKDIR /home/foamuser

RUN mkdir foam
WORKDIR /home/foamuser/foam
RUN git clone git://git.code.sf.net/p/foam-extend/foam-extend-4.1 foam-extend-4.1
WORKDIR /home/foamuser/foam/foam-extend-4.1 
RUN echo "export WM_CC='gcc-7'"  >> etc/prefs.sh
RUN echo "export WM_CXX='g++-7'"  >> etc/prefs.sh
RUN echo "export WM_MPLIB=SYSTEMOPENMPI" >> etc/prefs.sh
 
RUN sed -i -e 's=rpmbuild --define=rpmbuild --define "_build_id_links none" --define=' ThirdParty/tools/makeThirdPartyFunctionsForRPM
RUN sed -i -e 's/gcc/\$(WM_CC)/' wmake/rules/linux64Gcc/c
RUN sed -i -e 's/g++/\$(WM_CXX)/' wmake/rules/linux64Gcc/c++

RUN bash -c 'source etc/bashrc; ./Allwmake.firstInstall'

WORKDIR /home/foamuser
RUN git clone https://github.com/hoehnp/tutorials
WORKDIR /home/foamuser/tutorials/quickstart/solid-cpp
RUN git checkout add_foam_extend_tutorial
RUN bash -c "cmake . ; make" 

