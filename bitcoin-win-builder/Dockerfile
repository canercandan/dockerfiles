FROM ubuntu:precise
MAINTAINER Caner Candan <caner@candan.fr>

ENV TEMPDIR		/tmp
ENV HOST		x86_64-w64-mingw32
ENV INSTALLPREFIX	/staging64
ENV BUILDDIR		/build64
ENV INPUTS		/build/inputs
ENV BITS		64
ENV OUTDIR		/out
ENV TEMPDIR		/build/tmp

RUN mkdir build $INSTALLPREFIX $BUILDDIR $OUTDIR $TEMPDIR $INPUTS

RUN apt-get -qq update && \
    apt-get install -qqy mingw-w64 g++-mingw-w64 git-core unzip nsis \
    	    	    	 faketime autoconf2.13 libtool automake pkg-config \
			 bsdmainutils wget bzip2 zip psmisc build-essential \
			 unzip libz-dev

WORKDIR /build/inputs

RUN { \
    wget -q 'http://miniupnp.free.fr/files/download.php?file=miniupnpc-1.9.tar.gz' -O miniupnpc-1.9.tar.gz; \
    wget -q 'https://www.openssl.org/source/openssl-1.0.1h.tar.gz'; \
    wget -q 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'; \
    wget -q 'http://zlib.net/zlib-1.2.8.tar.gz'; \
    wget -q 'ftp://ftp.simplesystems.org/pub/png/src/history/libpng16/libpng-1.6.8.tar.gz'; \
    wget -q 'https://fukuchi.org/works/qrencode/qrencode-3.4.3.tar.bz2'; \
    wget -q 'https://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.bz2'; \
    wget -q 'https://svn.boost.org/trac/boost/raw-attachment/ticket/7262/boost-mingw.patch' -O boost-mingw-gas-cross-compile-2013-03-03.patch; \
    wget -q 'https://download.qt-project.org/official_releases/qt/5.2/5.2.0/single/qt-everywhere-opensource-src-5.2.0.tar.gz'; \
    wget -q 'https://download.qt-project.org/official_releases/qt/5.2/5.2.1/single/qt-everywhere-opensource-src-5.2.1.tar.gz'; \
    wget -q 'https://download.qt-project.org/archive/qt/4.6/qt-everywhere-opensource-src-4.6.4.tar.gz'; \
    wget -q 'https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2'; \
    wget -q 'https://github.com/mingwandroid/toolchain4/archive/10cc648683617cca8bcbeae507888099b41b530c.tar.gz'; \
    wget -q 'http://www.opensource.apple.com/tarballs/cctools/cctools-809.tar.gz'; \
    wget -q 'http://www.opensource.apple.com/tarballs/dyld/dyld-195.5.tar.gz'; \
    wget -q 'http://www.opensource.apple.com/tarballs/ld64/ld64-127.2.tar.gz'; \
    wget -q 'http://pkgs.fedoraproject.org/repo/pkgs/cdrkit/cdrkit-1.1.11.tar.gz/efe08e2f3ca478486037b053acd512e9/cdrkit-1.1.11.tar.gz'; \
    wget -q 'https://github.com/theuni/libdmg-hfsplus/archive/libdmg-hfsplus-v0.1.tar.gz'; \
    wget -q 'http://llvm.org/releases/3.2/clang+llvm-3.2-x86-linux-ubuntu-12.04.tar.gz' -O clang-llvm-3.2-x86-linux-ubuntu-12.04.tar.gz; \
    wget -q 'https://raw.githubusercontent.com/theuni/osx-cross-depends/master/patches/cdrtools/genisoimage.diff' -O cdrkit-deterministic.patch; \
    }

#wget -q 'http://cdrkit.org/releases/cdrkit-1.1.11.tar.gz'

# Input Integrity Check
RUN { \
    echo "fff00023dd79486d444c8e29922f4072e1d451fc5a4d2b6075852ead7f2b7b52  boost_1_55_0.tar.bz2" | shasum -c && \
    echo "d2b7f6a1d7051faef3c9cf41a92fa3671d905ef1e1da920d07651a43299f6268  boost-mingw-gas-cross-compile-2013-03-03.patch" | shasum -c && \
    echo "9d1c8a9836aa63e2c6adb684186cbd4371c9e9dcc01d6e3bb447abf2d4d3d093  openssl-1.0.1h.tar.gz"  | sha256sum -c && \
    echo "12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef  db-4.8.30.NC.tar.gz"    | sha256sum -c && \
    echo "2923e453e880bb949e3d4da9f83dd3cb6f08946d35de0b864d0339cf70934464  miniupnpc-1.9.tar.gz"   | sha256sum -c && \
    echo "36658cb768a54c1d4dec43c3116c27ed893e88b02ecfcb44f2166f9c0b7f2a0d  zlib-1.2.8.tar.gz"      | sha256sum -c && \
    echo "32c7acf1608b9c8b71b743b9780adb7a7b347563dbfb4a5263761056da44cc96  libpng-1.6.8.tar.gz"    | sha256sum -c && \
    echo "dfd71487513c871bad485806bfd1fdb304dedc84d2b01a8fb8e0940b50597a98  qrencode-3.4.3.tar.bz2" | sha256sum -c && \
    echo "395ec72277c5786c65b8163ef5817fd03d0a1f524a6d47f53624baf8056f1081  qt-everywhere-opensource-src-5.2.0.tar.gz" | sha256sum -c; \
    }

WORKDIR /build64

RUN { \
    tar --warning=no-timestamp -xjf $INPUTS/boost_1_55_0.tar.bz2; \
    tar xzf $INPUTS/openssl-1.0.1h.tar.gz; \
    tar xzf $INPUTS/db-4.8.30.NC.tar.gz; \
    tar xzf $INPUTS/miniupnpc-1.9.tar.gz; \
    tar xzf $INPUTS/zlib-1.2.8.tar.gz; \
    tar xzf $INPUTS/libpng-1.6.8.tar.gz; \
    tar xjf $INPUTS/qrencode-3.4.3.tar.bz2; \
    tar xzf $INPUTS/qt-everywhere-opensource-src-5.2.0.tar.gz; \
    }

WORKDIR /build64/boost_1_55_0

RUN { \
    echo "using gcc : $($HOST-g++ -E -dM $(mktemp --suffix=.h) | grep __VERSION__ | cut -d ' ' -f 3 | cut -d '"' -f 2) : $HOST-g++"; \
    echo "    :"; \
    echo "    <rc>$HOST-windres"; \
    echo "    <archiver>$HOST-ar"; \
    echo "    <cxxflags>-frandom-seed=boost1"; \
    echo "    <ranlib>$HOST-ranlib"; \
    echo ";"; \
    } > user-config.jam

RUN ./bootstrap.sh --without-icu

# Workaround: Upstream boost dev refuses to include patch that would
#             allow Free Software cross-compile toolchain to work This
#             patch was authored by the Fedora package developer and
#             ships in Fedora's mingw32-boost.  Please obtain the
#             exact patch that matches the above sha256sum from one of
#             the following mirrors.
#
# Read History:   https://svn.boost.org/trac/boost/ticket/7262
# History Mirror: http://rose.makesad.us/~paulproteus/mirrors/7262%20Boost.Context%20fails%20to%20build%20using%20MinGW.html
#
# Patch:          https://svn.boost.org/trac/boost/raw-attachment/ticket/7262/boost-mingw.patch
# Patch Mirror:   http://wtogami.fedorapeople.org/boost-mingw-gas-cross-compile-2013-03-03.patch
# Patch Mirror:   http://mindstalk.net/host/boost-mingw-gas-cross-compile-2013-03-03.patch
# Patch Mirror:   http://rose.makesad.us/~paulproteus/mirrors/boost-mingw-gas-cross-compile-2013-03-03.patch
RUN patch -p0 < $INPUTS/boost-mingw-gas-cross-compile-2013-03-03.patch

# Bug Workaround: boost-1.54.0 broke the ability to disable zlib, still broken in 1.55
# https://svn.boost.org/trac/boost/ticket/9156
RUN { \
    sed -i 's^\[ ac.check-library /zlib//zlib : <library>/zlib//zlib^^' libs/iostreams/build/Jamfile.v2 && \
    sed -i 's^<source>zlib.cpp <source>gzip.cpp \]^^' libs/iostreams/build/Jamfile.v2; \
    }

# http://statmt.org/~s0565741/software/boost_1_52_0/libs/context/doc/html/context/requirements.html
# "For cross-compiling the lib you must specify certain additional
# properties at bjam command line: target-os, abi, binary-format,
# architecture and address-model."
RUN ./bjam toolset=gcc binary-format=pe target-os=windows threadapi=win32 \
    address-model=$BITS threading=multi variant=release link=static \
    runtime-link=static --user-config=user-config.jam --without-mpi \
    --without-python -sNO_BZIP2=1 -sNO_ZLIB=1 --layout=tagged \
    --build-type=complete --prefix="$INSTALLPREFIX" $MAKEOPTS install

# post-process all generated libraries to be deterministic
# extract them to a temporary directory then re-build them deterministically
RUN { \
    for LIB in $(find $INSTALLPREFIX -name \*.a); do \
        rm -rf $TEMPDIR && mkdir $TEMPDIR && cd $TEMPDIR; \
        $HOST-ar xv $LIB | cut -b5- > /tmp/list.txt; \
        rm $LIB; \
        $HOST-ar crsD $LIB $(cat /tmp/list.txt); \
    done; \
    }

WORKDIR /staging64

RUN find | sort | zip -X@ $OUTDIR/boost-win$BITS-1.55.0.zip

# installation of openssl
WORKDIR /build64/openssl-1.0.1h
ENV OPENSSL_TGT mingw64
RUN { \
    ./Configure --cross-compile-prefix=$HOST- ${OPENSSL_TGT} no-shared no-dso --openssldir=$INSTALLPREFIX && \
    make && make install_sw; \
    }

# installation of db4.8
WORKDIR /build64/db-4.8.30.NC/build_unix
RUN { \
    ../dist/configure --prefix=$INSTALLPREFIX --enable-mingw --enable-cxx --host=$HOST --disable-shared && \
    make $MAKEOPTS library_build && \
    make install_lib install_include; \
    }

# installation of miniupnpc
WORKDIR /build64/miniupnpc-1.9
ADD miniupnpc-1.9.patch /build64/miniupnpc-1.9/
RUN { \
    sed -i "s/VERSIONHERE/$(cat VERSION)/" miniupnpc-1.9.patch && \
    patch -p1 < miniupnpc-1.9.patch && \
    mkdir -p dll && \
    make -f Makefile.mingw CC=$HOST-gcc AR=$HOST-ar libminiupnpc.a && \
    install -d $INSTALLPREFIX/include/miniupnpc && \
    install *.h $INSTALLPREFIX/include/miniupnpc && \
    install libminiupnpc.a  $INSTALLPREFIX/lib; \
    }

# installation of zlib
WORKDIR /build64/zlib-1.2.8
RUN CROSS_PREFIX=$HOST- ./configure --prefix=$INSTALLPREFIX --static && make && make install

# installation of libpng
WORKDIR /build64/libpng-1.6.8
ENV OPT -O2
RUN CPPFLAGS="${OPT} -I$INSTALLPREFIX/include" CFLAGS="${OPT} -I$INSTALLPREFIX/include" LDFLAGS="${OPT} -L$INSTALLPREFIX/lib" ./configure --disable-shared --prefix=$INSTALLPREFIX --host=$HOST && make $MAKEOPTS && make install

# installation of qrencode
WORKDIR /build64/qrencode-3.4.3
# Workaround to prevent re-configuring by make (resulting in missing m4 error); make all files have a date in the past
RUN { \
    png_CFLAGS="-I$INSTALLPREFIX/include" png_LIBS="-L$INSTALLPREFIX/lib -lpng" ./configure --prefix=$INSTALLPREFIX --host=$HOST --enable-static --disable-shared --without-tools --disable-dependency-tracking && \
    find . -print0 | xargs -r0 touch -t 200001010000 && \
    make && make install; \
    }

# post-process all generated libraries to be deterministic
# extract them to a temporary directory then re-build them deterministically
RUN { \
    for LIB in $(find $INSTALLPREFIX -name \*.a); do \
        rm -rf $TEMPDIR && mkdir $TEMPDIR && cd $TEMPDIR; \
        $HOST-ar xv $LIB | cut -b5- > /tmp/list.txt; \
        rm $LIB; \
        $HOST-ar crsD $LIB $(cat /tmp/list.txt); \
    done; \
    }

WORKDIR /staging64
RUN find include lib | sort | zip -X@ $OUTDIR/bitcoin-deps-win$BITS.zip

# Qt: workaround for determinism in resource ordering
#  Qt5's rcc uses a QHash to store the files for the resource.
#  A security fix in QHash makes the ordering of keys to be different on every run
#  (https://qt.gitorious.org/qt/qtbase/commit/c01eaa438200edc9a3bbcd8ae1e8ded058bea268).
#  This is good in general but qrc shouldn't be doing a traversal over a randomized container.
#  The thorough solution would be to use QMap instead of QHash, but this requires patching Qt.
#  For now luckily there is a test mode that forces a fixed seed.
ENV QT_RCC_TEST	1

# install dependencies
ENV DEPSDIR	/deps64
RUN mkdir -p $INSTALLPREFIX/host/bin $DEPSDIR
WORKDIR /deps64
RUN unzip $OUTDIR/bitcoin-deps-win${BITS}.zip

# installation of Qt
WORKDIR /build64/qt-everywhere-opensource-src-5.2.0
ENV SPECNAME	win32-g++
ENV SPECFILE	qtbase/mkspecs/win32-g++/qmake.conf
# Compile static libraries, and use statically linked openssl (-openssl-linked):
RUN { \
    sed 's/qt_instdate=`date +%Y-%m-%d`/qt_instdate=2011-01-30/' -i qtbase/configure && \
    sed --posix "s|QMAKE_CFLAGS            = -pipe -fno-keep-inline-dllexport|QMAKE_CFLAGS\t\t= -pipe -fno-keep-inline-dllexport -isystem /usr/$HOST/include/ -frandom-seed=qtbuild -I$DEPSDIR/include|" -i ${SPECFILE} && \
    sed --posix "s|QMAKE_LFLAGS            =|QMAKE_LFLAGS\t\t= -L$DEPSDIR/lib|" -i ${SPECFILE} && \
    OPENSSL_LIBS="-L$DEPSDIR/lib -lssl -lcrypto -lgdi32" ./configure -prefix $INSTALLPREFIX -bindir $INSTALLPREFIX/host/bin -confirm-license -release -opensource -static -xplatform $SPECNAME -device-option CROSS_COMPILE="$HOST-" -no-audio-backend -no-javascript-jit -no-sql-sqlite -no-sql-odbc -no-nis -no-cups -no-iconv -no-dbus -no-gif -no-opengl -no-compile-examples -no-feature-style-windowsce -no-feature-style-windowsmobile -no-qml-debug -openssl-linked -skip qtsvg -skip qtwebkit -skip qtwebkit-examples -skip qtserialport -skip qtdeclarative -skip qtmultimedia -skip qtimageformats -skip qtlocation -skip qtsensors -skip qtquick1 -skip qtquickcontrols -skip qtactiveqt -skip qtconnectivity -skip qtwinextras -skip qtxmlpatterns -skip qtscript -skip qtdoc -system-libpng -system-zlib -continue && \
    make $MAKEOPTS install; \
    }

# post-process all generated libraries to be deterministic
# extract them to a temporary directory then re-build them deterministically
RUN { \
    for LIB in $(find $INSTALLPREFIX -name \*.a); do \
        rm -rf $TEMPDIR && mkdir $TEMPDIR && cd $TEMPDIR; \
        $HOST-ar xv $LIB | cut -b5- > /tmp/list.txt; \
        rm $LIB; \
        $HOST-ar crsD $LIB $(cat /tmp/list.txt); \
    done; \
    }

WORKDIR /staging64

# fix up timestamps before packaging
RUN { \
    rm host/bin/qtpaths.exe lib/libQt5Bootstrap.a lib/libQt5Bootstrap.la && \
    find -print0 | xargs -r0 touch && \
    find | sort | zip -X@ $OUTDIR/qt-win${BITS}-5.2.0.zip; \
    }

ENV OPTFLAGS	-O2

# Qt: workaround for determinism in resource ordering
#  Qt5's rcc uses a QHash to store the files for the resource.
#  A security fix in QHash makes the ordering of keys to be different on every run
#  (https://qt.gitorious.org/qt/qtbase/commit/c01eaa438200edc9a3bbcd8ae1e8ded058bea268).
#  This is good in general but qrc shouldn't be doing a traversal over a randomized container.
#  The thorough solution would be to use QMap instead of QHash, but this requires patching Qt.
#  For now luckily there is a test mode that forces a fixed seed.
ENV QT_RCC_TEST	1
ENV BINDIR	/out/64

RUN { \
    mkdir $BINDIR /build/bitcoin && \
    git clone https://github.com/bitcoin/bitcoin.git && \
    export PATH=$INSTALLPREFIX/host/bin:$PATH; \
    }

WORKDIR /build/inputs
RUN echo "13bfc5ae543cf3aa180ac2485c0bc89495e3ae711fc6fab4f8ffe90dfb4bb677  protobuf-2.5.0.tar.bz2" | sha256sum -c

WORKDIR /build64
RUN tar xjf $INPUTS/protobuf-2.5.0.tar.bz2

WORKDIR /build64/protobuf-2.5.0
# build a native (linux) protoc and recompile with the mingw cross-compiler:
RUN { \
    ./configure --enable-shared=no --disable-dependency-tracking --without-zlib CXXFLAGS="-frandom-seed=11 ${OPTFLAGS}" && \
    make && \
    cp src/protoc $INSTALLPREFIX/host/bin && \
    make distclean && \
    ./configure --prefix=$INSTALLPREFIX --enable-shared=no --disable-dependency-tracking --without-zlib --with-protoc=$INSTALLPREFIX/host/bin/protoc --host=$HOST CXXFLAGS="-frandom-seed=11 ${OPTFLAGS}" && \
    make && make install; \
    }

# post-process all generated libraries to be deterministic
# extract them to a temporary directory then re-build them deterministically
RUN { \
    for LIB in $(find $INSTALLPREFIX -name \*.a); do \
        rm -rf $TEMPDIR && mkdir $TEMPDIR && cd $TEMPDIR; \
        $HOST-ar xv $LIB | cut -b5- > /tmp/list.txt; \
        rm $LIB; \
        $HOST-ar crsD $LIB $(cat /tmp/list.txt); \
    done; \
    }

WORKDIR /staging64

RUN find include lib host | sort | zip -X@ $OUTDIR/protobuf-win$BITS-2.5.0.zip

RUN { \
    unzip -n $OUTDIR/qt-win${BITS}-5.2.0.zip && \
    unzip -n $OUTDIR/boost-win${BITS}-1.55.0.zip && \
    unzip -n $OUTDIR/bitcoin-deps-win${BITS}.zip && \
    unzip -n $OUTDIR/protobuf-win${BITS}-2.5.0.zip; \
    }

WORKDIR /build/bitcoin

RUN git clone https://github.com/bitcoin/bitcoin.git .

RUN { \
    ./autogen.sh && \
    ./configure --bindir=$OUTDIR --prefix=$INSTALLPREFIX --host=$HOST --with-qt-plugindir=$INSTALLPREFIX/plugins  --with-qt-incdir=$INSTALLPREFIX/include --with-qt-bindir=$INSTALLPREFIX/host/bin --with-boost=$INSTALLPREFIX --disable-maintainer-mode --with-protoc-bindir=$INSTALLPREFIX/host/bin --disable-dependency-tracking CPPFLAGS="-I$INSTALLPREFIX/include ${OPTFLAGS}" LDFLAGS="-L$INSTALLPREFIX/lib ${OPTFLAGS}" CXXFLAGS="-frandom-seed=bitcoin ${OPTFLAGS}" && \
    make dist; \
    }

RUN mkdir -p /build64/distsrc
WORKDIR /build64/distsrc

RUN { \
    tar --strip-components=1 -xf /build/bitcoin/`echo bitcoin-*.tar.gz` && \
    ./configure --enable-upnp-default --bindir=$BINDIR --prefix=$INSTALLPREFIX --host=$HOST --with-qt-plugindir=$INSTALLPREFIX/plugins  --with-qt-incdir=$INSTALLPREFIX/include --with-qt-bindir=$INSTALLPREFIX/host/bin --with-boost=$INSTALLPREFIX --disable-maintainer-mode --with-protoc-bindir=$INSTALLPREFIX/host/bin --disable-dependency-tracking CPPFLAGS="-I$INSTALLPREFIX/include ${OPTFLAGS}" LDFLAGS="-L$INSTALLPREFIX/lib ${OPTFLAGS}" CXXFLAGS="-frandom-seed=bitcoin ${OPTFLAGS}" && \
    make $MAKEOPTS && make deploy && make install-strip && \
    cp -f bitcoin-*setup*.exe $BINDIR/; \
    }

# sort distribution tar file and normalize user/group/mtime information for deterministic output
RUN { \
    cd /build/bitcoin && \
    DISTNAME=`echo bitcoin-*.tar.gz` && \
    mkdir -p $OUTDIR/src && \
    rm -rf $TEMPDIR && \
    mkdir -p $TEMPDIR && \
    cd $TEMPDIR && \
    tar -xvf /build/bitcoin/$DISTNAME | sort | tar --no-recursion -cT /dev/stdin --mode='u+rw,go+r-w,a+X' --owner=0 --group=0 | gzip -n > $OUTDIR/src/$DISTNAME; \
    }

WORKDIR /dist

VOLUME /dist

CMD cp -a /out/* /dist/
