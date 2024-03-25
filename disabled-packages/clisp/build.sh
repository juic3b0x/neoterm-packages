NEOTERM_PKG_HOMEPAGE=http://www.clisp.org/
NEOTERM_PKG_DESCRIPTION="GNU CLISP - an ANSI Common Lisp Implementation"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.49
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/project/clisp/clisp/${NEOTERM_PKG_VERSION}/clisp-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256="8132ff353afaa70e6b19367a25ae3d5a43627279c25647c220641fed00f8e890"
NEOTERM_PKG_DEPENDS="readline, libandroid-support"
NEOTERM_MAKE_PROCESSES=1

neoterm_step_configure() {
	cd $NEOTERM_PKG_BUILDDIR

	export XCPPFLAGS="$CPPFLAGS"
	export XCFLAGS="$CFLAGS"
	export XLDFLAGS="$LDFLAGS"

	unset CC
	unset CPPFLAGS
	unset CFLAGS
	unset LDFLAGS

	$NEOTERM_PKG_SRCDIR/configure \
		--host=$NEOTERM_HOST_PLATFORM \
		--prefix=$NEOTERM_PREFIX \
		--enable-shared \
		--disable-static \
		--srcdir=$NEOTERM_PKG_SRCDIR \
		--ignore-absence-of-libsigsegv \
		ac_cv_func_select=yes
}
