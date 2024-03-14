NEOTERM_PKG_HOMEPAGE=https://valgrind.org/
NEOTERM_PKG_DESCRIPTION="Instrumentation framework for building dynamic analysis tools"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.22.0"
NEOTERM_PKG_SRCURL=http://sourceware.org/pub/valgrind/valgrind-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=c811db5add2c5f729944caf47c4e7a65dcaabb9461e472b578765dd7bf6d2d4c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_DEPENDS="binutils-cross"
NEOTERM_PKG_BREAKS="valgrind-dev"
NEOTERM_PKG_REPLACES="valgrind-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-tmpdir=$NEOTERM_PREFIX/tmp"

neoterm_step_pre_configure() {
	CFLAGS=${CFLAGS/-fstack-protector-strong/}

	if [ "$NEOTERM_ARCH" == "aarch64" ]; then
		cp $NEOTERM_PKG_BUILDER_DIR/aarch64-setjmp.S $NEOTERM_PKG_SRCDIR
		patch --silent -p1 < $NEOTERM_PKG_BUILDER_DIR/coregrindmake.am.diff
		patch --silent -p1 < $NEOTERM_PKG_BUILDER_DIR/memcheckmake.am.diff
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-only64bit"
	elif [ "$NEOTERM_ARCH" == "arm" ]; then
		# valgrind doesn't like arm; armv7 works, though.
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --host=armv7-linux-androideabi"
		# http://lists.busybox.net/pipermail/buildroot/2013-November/082270.html:
		# "valgrind uses inline assembly that is not Thumb compatible":
		CFLAGS=${CFLAGS/-mthumb/}
		# ```
		# <inline asm>:1:41: error: expected '%<type>' or "<type>"
		# .pushsection ".debug_gdb_scripts", "MS",@progbits,1
		#                                         ^
		# ```
		# See also https://github.com/llvm/llvm-project/issues/24438.
		neoterm_setup_no_integrated_as
	fi

	autoreconf -fi
}
