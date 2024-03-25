NEOTERM_PKG_HOMEPAGE=https://www.tcl.tk/
NEOTERM_PKG_DESCRIPTION="Powerful but easy to learn dynamic programming language"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="license.terms"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=8.6.13
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/tcl/Tcl/${NEOTERM_PKG_VERSION}/tcl${NEOTERM_PKG_VERSION}-src.tar.gz
NEOTERM_PKG_SHA256=43a1fae7412f61ff11de2cfd05d28cfc3a73762f354a417c62370a54e2caf066
NEOTERM_PKG_DEPENDS="zlib"
NEOTERM_PKG_BREAKS="tcl-dev, tcl-static"
NEOTERM_PKG_REPLACES="tcl-dev, tcl-static"
NEOTERM_PKG_NO_STATICSPLIT=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_memcmp_working=yes
ac_cv_func_memcmp=yes
ac_cv_func_strtod=yes
ac_cv_func_strtoul=yes
tcl_cv_strstr_unbroken=ok
tcl_cv_strtod_buggy=ok
tcl_cv_strtod_unbroken=ok
tcl_cv_strtoul_unbroken=ok
--disable-rpath
--enable-man-symlinks
--mandir=$NEOTERM_PREFIX/share/man
"

neoterm_step_pre_configure() {
	rm -rf $NEOTERM_PKG_SRCDIR/pkgs/sqlite3* # libsqlite-tcl is a separate package
	NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR/unix
	CFLAGS+=" -DBIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD"
}

neoterm_step_post_make_install() {
	# expect needs private headers
	make install-private-headers
	local _MAJOR_VERSION=${NEOTERM_PKG_VERSION:0:3}
	cd $NEOTERM_PREFIX/bin
	ln -f -s tclsh$_MAJOR_VERSION tclsh

	# Needed to install $NEOTERM_PKG_LICENSE_FILE.
	NEOTERM_PKG_SRCDIR=$(dirname "$NEOTERM_PKG_SRCDIR")

	#avoid conflict with perl
	mv $NEOTERM_PREFIX/share/man/man3/Thread.3 $NEOTERM_PREFIX/share/man/man3/Tcl_Thread.3
}
