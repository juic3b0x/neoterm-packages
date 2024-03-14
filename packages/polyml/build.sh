NEOTERM_PKG_HOMEPAGE=https://www.polyml.org/
NEOTERM_PKG_DESCRIPTION="A Standard ML implementation"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.9.1"
NEOTERM_PKG_SRCURL=https://github.com/polyml/polyml/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=52f56a57a4f308f79446d479e744312195b298aa65181893bce2dfc023a3663c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-posix-semaphore, libc++, libffi, libgmp"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-pic
--disable-native-codegeneration
"

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	local NEOTERM_ORIG_PATH=$PATH
	mkdir -p native
	pushd native
	export PATH=$(pwd):$NEOTERM_ORIG_PATH
	$NEOTERM_PKG_SRCDIR/configure \
		CC="gcc -m${NEOTERM_ARCH_BITS}" CXX="g++ -m${NEOTERM_ARCH_BITS}" \
		--prefix=$_PREFIX_FOR_BUILD \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
	sed -i -e 's/^\(#define HOSTARCHITECTURE\)_X32 1/\1_X86 1/g' config.h
	make -j $NEOTERM_MAKE_PROCESSES
	make install
	popd

	local arch
	case "$NEOTERM_ARCH" in
		aarch64 )
			arch=AARCH64 ;;
		arm )
			arch=ARM ;;
		x86_64 )
			arch=X86_64 ;;
		i686 )
			arch=X86 ;;
		* )
			echo "ERROR: Unknown architecture: $NEOTERM_ARCH"
			return 1 ;;
	esac

	mkdir -p cross
	pushd cross
	export PATH=$_PREFIX_FOR_BUILD/bin:$NEOTERM_ORIG_PATH
	$NEOTERM_PKG_SRCDIR/configure \
		CC="gcc -m${NEOTERM_ARCH_BITS}" CXX="g++ -m${NEOTERM_ARCH_BITS}" \
		--prefix=$(pwd) \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
	sed -i -e '/^#define HOSTARCHITECTURE_/d' config.h
	echo >> config.h
	echo "#define HOSTARCHITECTURE_${arch} 1" >> config.h
	make -j $NEOTERM_MAKE_PROCESSES -C libpolyml libpolyml.la
	make -j $NEOTERM_MAKE_PROCESSES polyimport
	make -j $NEOTERM_MAKE_PROCESSES -C libpolymain libpolymain.la
	make -j $NEOTERM_MAKE_PROCESSES poly
	export PATH=$(pwd):$NEOTERM_ORIG_PATH
	popd
}

neoterm_step_pre_configure() {
	_NEED_DUMMY_LIBSTDCXX_SO=
	_LIBSTDCXX_SO=$NEOTERM_PREFIX/lib/libstdc++.so
	if [ ! -e $_LIBSTDCXX_SO ]; then
		_NEED_DUMMY_LIBSTDCXX_SO=true
		echo 'INPUT(-lc++_shared)' > $_LIBSTDCXX_SO
	fi

	LDFLAGS+=" -landroid-posix-semaphore $($CC -print-libgcc-file-name)"
}

neoterm_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBSTDCXX_SO ]; then
		rm -f $_LIBSTDCXX_SO
	fi
}
