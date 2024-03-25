NEOTERM_PKG_HOMEPAGE=https://sarnold.github.io/cccc/
NEOTERM_PKG_DESCRIPTION="Source code counter and metrics tool for C++, C, and Java"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.2.0
NEOTERM_PKG_SRCURL=https://github.com/sarnold/cccc/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c03b29d45f1acb6f669b6d6d193dcdf5603f8c2758f0fb4bc1eeacef92ecb78a
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="cccc"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_MAKE_PROCESSES=1

neoterm_step_host_build() {
	find $NEOTERM_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;

	export CC="gcc -m${NEOTERM_ARCH_BITS}"
	export CCC="g++ -m${NEOTERM_ARCH_BITS}"

	sh build_posixgcc.sh
}

neoterm_step_pre_configure() {
	export CCC="$CXX"
	CFLAGS+=" $CPPFLAGS"
	NEOTERM_PKG_EXTRA_MAKE_ARGS+="
		ANTLR=$NEOTERM_PKG_HOSTBUILD_DIR/pccts/bin/antlr
		DLG=$NEOTERM_PKG_HOSTBUILD_DIR/pccts/bin/dlg
		"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin cccc/cccc
}
