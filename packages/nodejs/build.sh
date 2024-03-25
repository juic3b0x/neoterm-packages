NEOTERM_PKG_HOMEPAGE=https://nodejs.org/
NEOTERM_PKG_DESCRIPTION="Open Source, cross-platform JavaScript runtime environment"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@neoterm.dev>"
NEOTERM_PKG_VERSION=21.6.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://nodejs.org/dist/v${NEOTERM_PKG_VERSION}/node-v${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=191294d445d1e6800359acc8174529b1e18e102147dc5f596030d3dce96931e5
# thunder-coding: don't try to autoupdate nodejs, that thing takes 2 whole hours to build for a single arch, and requires a lot of patch updates everytime. Also I run tests everytime I update it to ensure least bugs
NEOTERM_PKG_AUTO_UPDATE=false
# Note that we do not use a shared libuv to avoid an issue with the Android
# linker, which does not use symbols of linked shared libraries when resolving
# symbols on dlopen(). See https://github.com/juic3b0x/neoterm-packages/issues/462.
NEOTERM_PKG_DEPENDS="libc++, openssl, c-ares, libicu, zlib"
NEOTERM_PKG_CONFLICTS="nodejs-lts, nodejs-current"
NEOTERM_PKG_BREAKS="nodejs-dev"
NEOTERM_PKG_REPLACES="nodejs-current, nodejs-dev"
NEOTERM_PKG_SUGGESTS="clang, make, pkg-config, python"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/node_modules/npm/html lib/node_modules/npm/make.bat share/systemtap lib/dtrace"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	# Prevent caching of host build:
	rm -Rf $NEOTERM_PKG_HOSTBUILD_DIR
}

neoterm_step_host_build() {
	local ICU_VERSION=74.1
	local ICU_TAR=icu4c-${ICU_VERSION//./_}-src.tgz
	local ICU_DOWNLOAD=https://github.com/unicode-org/icu/releases/download/release-${ICU_VERSION//./-}/$ICU_TAR
	neoterm_download \
		$ICU_DOWNLOAD\
		$NEOTERM_PKG_CACHEDIR/$ICU_TAR \
		86ce8e60681972e60e4dcb2490c697463fcec60dd400a5f9bffba26d0b52b8d0
	tar xf $NEOTERM_PKG_CACHEDIR/$ICU_TAR
	cd icu/source
	if [ "$NEOTERM_ARCH_BITS" = 32 ]; then
		./configure --prefix $NEOTERM_PKG_HOSTBUILD_DIR/icu-installed \
			--disable-samples \
			--disable-tests \
			--build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
	else
		./configure --prefix $NEOTERM_PKG_HOSTBUILD_DIR/icu-installed \
			--disable-samples \
			--disable-tests
	fi
	make -j $NEOTERM_MAKE_PROCESSES install
}

neoterm_step_pre_configure() {
	neoterm_setup_ninja
}

neoterm_step_configure() {
	local DEST_CPU
	if [ $NEOTERM_ARCH = "arm" ]; then
		DEST_CPU="arm"
	elif [ $NEOTERM_ARCH = "i686" ]; then
		DEST_CPU="ia32"
	elif [ $NEOTERM_ARCH = "aarch64" ]; then
		DEST_CPU="arm64"
	elif [ $NEOTERM_ARCH = "x86_64" ]; then
		DEST_CPU="x64"
	else
		neoterm_error_exit "Unsupported arch '$NEOTERM_ARCH'"
	fi

	export GYP_DEFINES="host_os=linux"
	export CC_host=gcc
	export CXX_host=g++
	export LINK_host=g++

	LDFLAGS+=" -ldl"
	# See note above NEOTERM_PKG_DEPENDS why we do not use a shared libuv.
	# When building with ninja, build.ninja is generated for both Debug and Release builds.
	./configure \
		--prefix=$NEOTERM_PREFIX \
		--dest-cpu=$DEST_CPU \
		--dest-os=android \
		--shared-cares \
		--shared-openssl \
		--shared-zlib \
		--with-intl=system-icu \
		--cross-compiling \
		--ninja

	export LD_LIBRARY_PATH=$NEOTERM_PKG_HOSTBUILD_DIR/icu-installed/lib
	sed -i \
		-e "s|\-I$NEOTERM_PREFIX/include||g" \
		-e "s|\-L$NEOTERM_PREFIX/lib||g" \
		-e "s|-licui18n||g" \
		-e "s|-licuuc||g" \
		-e "s|-licudata||g" \
		$NEOTERM_PKG_SRCDIR/out/{Release,Debug}/obj.host/node_js2c.ninja
	sed -i \
		-e "s|\-I$NEOTERM_PREFIX/include|-I$NEOTERM_PKG_HOSTBUILD_DIR/icu-installed/include|g" \
		-e "s|\-L$NEOTERM_PREFIX/lib|-L$NEOTERM_PKG_HOSTBUILD_DIR/icu-installed/lib|g" \
		$(find $NEOTERM_PKG_SRCDIR/out/{Release,Debug}/obj.host -name '*.ninja')
}

neoterm_step_make() {
	if [ "${NEOTERM_DEBUG_BUILD}" = "true" ]; then
		ninja -C out/Debug -j "${NEOTERM_MAKE_PROCESSES}"
	else
		ninja -C out/Release -j "${NEOTERM_MAKE_PROCESSES}"
	fi
}

neoterm_step_make_install() {
	if [ "${NEOTERM_DEBUG_BUILD}" = "true" ]; then
		python tools/install.py install "" "${NEOTERM_PREFIX}" out/Debug/
	else
		python tools/install.py install "" "${NEOTERM_PREFIX}" out/Release/
	fi
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	npm config set foreground-scripts true
	EOF
}
