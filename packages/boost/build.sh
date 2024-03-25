NEOTERM_PKG_HOMEPAGE=https://boost.org
NEOTERM_PKG_DESCRIPTION="Free peer-reviewed portable C++ source libraries"
NEOTERM_PKG_LICENSE="BSL-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Never forget to always bump revision of reverse dependencies and rebuild them
# when bumping version.
NEOTERM_PKG_VERSION="1.83.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://boostorg.jfrog.io/artifactory/main/release/$NEOTERM_PKG_VERSION/source/boost_${NEOTERM_PKG_VERSION//./_}.tar.bz2
NEOTERM_PKG_SHA256=6478edfe2f3305127cffe8caf73ea0176c53769f4bf1585be237eb30798c3b8e
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libc++, libbz2, libiconv, liblzma, zlib"
NEOTERM_PKG_BUILD_DEPENDS="python"
NEOTERM_PKG_BREAKS="libboost-python (<= 1.65.1-2), boost-dev"
NEOTERM_PKG_REPLACES="libboost-python (<= 1.65.1-2), boost-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}

neoterm_step_make_install() {
	CXXFLAGS+=" -std=c++14"

	rm $NEOTERM_PREFIX/lib/libboost* -f
	rm $NEOTERM_PREFIX/include/boost -rf

	CC= CXX= LDFLAGS= CXXFLAGS= ./bootstrap.sh
	echo "using clang : $NEOTERM_ARCH : $CXX : <linkflags>-L$NEOTERM_PREFIX/lib ; " >> project-config.jam
	echo "using python : ${NEOTERM_PYTHON_VERSION} : $NEOTERM_PREFIX/bin/python3 : $NEOTERM_PREFIX/include/python${NEOTERM_PYTHON_VERSION} : $NEOTERM_PREFIX/lib ;" >> project-config.jam

	if [ "$NEOTERM_ARCH" = arm ] || [ "$NEOTERM_ARCH" = aarch64 ]; then
		BOOSTARCH=arm
		BOOSTABI=aapcs
	elif [ "$NEOTERM_ARCH" = i686 ] || [ "$NEOTERM_ARCH" = x86_64 ]; then
		BOOSTARCH=x86
		BOOSTABI=sysv
	fi

	if [ "$NEOTERM_ARCH" = x86_64 ] || [ "$NEOTERM_ARCH" = aarch64 ]; then
		BOOSTAM=64
	elif [ "$NEOTERM_ARCH" = i686 ] || [ "$NEOTERM_ARCH" = arm ]; then
		BOOSTAM=32
	fi

	./b2 target-os=android -j${NEOTERM_MAKE_PROCESSES} \
		define=BOOST_FILESYSTEM_DISABLE_STATX \
		include=$NEOTERM_PREFIX/include \
		toolset=clang-$NEOTERM_ARCH \
		--prefix="$NEOTERM_PREFIX"  \
		-q \
		--without-stacktrace \
		--disable-icu \
		-sNO_ZSTD=1 \
		cxxflags="$CXXFLAGS" \
		linkflags="$LDFLAGS" \
		architecture="$BOOSTARCH" \
		abi="$BOOSTABI" \
		address-model="$BOOSTAM" \
		boost.locale.icu=off \
		binary-format=elf \
		threading=multi \
		install
}
