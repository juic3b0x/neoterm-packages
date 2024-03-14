NEOTERM_PKG_HOMEPAGE=https://www.rust-lang.org
NEOTERM_PKG_DESCRIPTION="Rust compiler and utilities (nightly version)"
NEOTERM_PKG_DEPENDS="libc++, clang, openssl, lld, zlib, libllvm"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.61.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://static.rust-lang.org/dist/2022-03-07/rustc-nightly-src.tar.xz
NEOTERM_PKG_SHA256=7c7eb8e20f62c1701a369c033ed2c06f1de8c35c3673658e12691243a1d41558
NEOTERM_PKG_RM_AFTER_INSTALL="bin/llvm-* bin/llc bin/opt"

neoterm_step_configure () {
	case $NEOTERM_ARCH in
	    "aarch64" ) CARGO_TARGET_NAME=aarch64-linux-android ;;
	    "arm" ) CARGO_TARGET_NAME=armv7-linux-androideabi ;;
	    "i686" ) CARGO_TARGET_NAME=i686-linux-android ;;
	    "x86_64" ) CARGO_TARGET_NAME=x86_64-linux-android ;;
	esac

	export	RUST_BACKTRACE=1
	mkdir -p $NEOTERM_PREFIX/opt/rust-nightly
	RUST_PREFIX=$NEOTERM_PREFIX/opt/rust-nightly
	export PATH=$NEOTERM_PKG_TMPDIR/bin:$PATH
		sed $NEOTERM_PKG_BUILDER_DIR/config.toml \
			-e "s|@RUST_PREFIX@|$RUST_PREFIX|g" \
			-e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" \
			-e "s|@NEOTERM_HOST_PLATFORM@|$NEOTERM_HOST_PLATFORM|g" \
			-e "s|@NEOTERM_STANDALONE_TOOLCHAIN@|$NEOTERM_STANDALONE_TOOLCHAIN|g" \
			-e "s|@RUST_TARGET_TRIPLE@|$CARGO_TARGET_NAME|g" > $NEOTERM_PKG_BUILDDIR/config.toml

	export X86_64_UNKNOWN_LINUX_GNU_OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu
	export X86_64_UNKNOWN_LINUX_GNU_OPENSSL_INCLUDE_DIR=/usr/include
	export PKG_CONFIG_ALLOW_CROSS=1
	# for backtrace-sys
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu="-O2"
	export LLVM_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/libllvm/build.sh; echo $NEOTERM_PKG_VERSION)
	# it won't link with it in NEOTERM_PREFIX/lib without breaking other things.
	unset CC CXX CPP LD CFLAGS CXXFLAGS CPPFLAGS LDFLAGS PKG_CONFIG AR RANLIB
	ln -sf $PREFIX/lib/libLLVM-$LLVM_VERSION.so $NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/$NEOTERM_PKG_API_LEVEL/
	
	if [ -e $NEOTERM_PREFIX/lib/libtinfo.so.6 ]; then
	 	mv $NEOTERM_PREFIX/lib/libtinfo.so.6 $NEOTERM_PREFIX/lib/libtinfo.so.6.tmp
	fi
	if [ -e $NEOTERM_PREFIX/lib/libz.so.1 ]; then
		mv $NEOTERM_PREFIX/lib/libz.so.1 $NEOTERM_PREFIX/lib/libz.so.1.tmp
	fi
	if [ -e $NEOTERM_PREFIX/lib/libz.so ]; then
		mv $NEOTERM_PREFIX/lib/libz.so $NEOTERM_PREFIX/lib/libz.so.tmp
	fi
}

neoterm_step_make_install () {
	../src/x.py install --host $CARGO_TARGET_NAME --target $CARGO_TARGET_NAME --target wasm32-unknown-unknown || bash

	mv $NEOTERM_PREFIX/lib/libtinfo.so.6.tmp $NEOTERM_PREFIX/lib/libtinfo.so.6
	mv $NEOTERM_PREFIX/lib/libz.so.1.tmp $NEOTERM_PREFIX/lib/libz.so.1
	mv $NEOTERM_PREFIX/lib/libz.so.tmp $NEOTERM_PREFIX/lib/libz.so
}

neoterm_step_post_massage () {
	rm $NEOTERM_PKG_MASSAGEDIR/$RUST_PREFIX/lib/rustlib/{components,rust-installer-version,install.log,uninstall.sh}
	rm $NEOTERM_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/$NEOTERM_PKG_API_LEVEL/libLLVM-$LLVM_VERSION.so
	rm -f lib/libtinfo.so.6
	rm -f lib/libz.so
	rm -f lib/libz.so.1

	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/etc/profile.d
	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib
	echo "#!$NEOTERM_PREFIX/bin/sh" > $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/etc/profile.d/rust-nightly.sh
	echo "export PATH=$RUST_PREFIX/bin:\$PATH" >> $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/etc/profile.d/rust-nightly.sh

	ln -sf $NEOTERM_PREFIX/bin/lld $NEOTERM_PKG_MASSAGEDIR/$RUST_PREFIX/bin/rust-lld
}
neoterm_step_create_debscripts () {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "echo 'source \$PREFIX/etc/profile.d/rust-nightly.sh to use nightly'" >> postinst
	echo "echo 'or export RUSTC=\$PREFIX/opt/rust-nightly/bin/rustc'" >> postinst
}
