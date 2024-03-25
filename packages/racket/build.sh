NEOTERM_PKG_HOMEPAGE=https://racket-lang.org
NEOTERM_PKG_DESCRIPTION="Full-spectrum programming language going beyond Lisp and Scheme"
NEOTERM_PKG_LICENSE="GPL-3.0, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="8.12"
NEOTERM_PKG_SRCURL=https://www.cs.utah.edu/plt/installers/${NEOTERM_PKG_VERSION}/racket-minimal-${NEOTERM_PKG_VERSION}-src-builtpkgs.tgz
NEOTERM_PKG_SHA256=af5436cffc1f28ea943750c411c44687d4ff5028aca5cfca84598c426830ea7c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libffi, libiconv"
NEOTERM_PKG_NO_DEVELSPLIT=true
NEOTERM_PKG_HOSTBUILD=true

NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--enable-bc
--enable-bconly
"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-bc
--enable-bconly
--enable-racket=$NEOTERM_PKG_HOSTBUILD_DIR/bc/racketcgc
--enable-libs
--disable-shared
--disable-gracket
--enable-libffi"

neoterm_step_host_build() {
	"$NEOTERM_PKG_SRCDIR"/src/configure \
		$NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS
	make -j "$NEOTERM_MAKE_PROCESSES"
}

neoterm_step_pre_configure() {
	CPPFLAGS+=" -I$NEOTERM_PKG_SRCDIR/src/bc/include -I$NEOTERM_PKG_BUILDDIR/bc"
	LDFLAGS+=" -liconv -llog"
	export NEOTERM_PKG_SRCDIR="$NEOTERM_PKG_SRCDIR/src"
}
