NEOTERM_PKG_HOMEPAGE=http://smalltalk.gnu.org/
NEOTERM_PKG_DESCRIPTION="A free implementation of the Smalltalk-80 language"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=3.2.91
NEOTERM_PKG_REVISION=14
NEOTERM_PKG_SRCURL=ftp://alpha.gnu.org/gnu/smalltalk/smalltalk-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=13a7480553c182dbb8092bd4f215781b9ec871758d1db7045c2d8587e4d1bef9
NEOTERM_PKG_DEPENDS="gdbm, glib, libandroid-support, libexpat, libffi, libgmp, libiconv, libltdl, libsigsegv, libsqlite, zlib"
NEOTERM_PKG_BREAKS="smalltalk-dev"
NEOTERM_PKG_REPLACES="smalltalk-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	(cd "$NEOTERM_PKG_SRCDIR"
		autoreconf -i
		sed 's/int yylineno = 1;//g' -i libgst/genpr-scan.l
		sed 's/int yylineno = 1;//g' -i libgst/genvm-scan.l
		sed 's/int yylineno = 1;//g' -i libgst/genbc-scan.l
	)

	# Building bloxtk on archlinux fails with this error: https://bugs.gentoo.org/582936
	"$NEOTERM_PKG_SRCDIR"/configure --disable-gtk --disable-bloxtk
	make
}

neoterm_step_pre_configure() {
	autoreconf -fi

	export LD_LIBRARY_PATH="$NEOTERM_PKG_HOSTBUILD_DIR/libgst/.libs"
	sed -i \
		"s%@NEOTERM_PKG_HOSTBUILD_DIR@%$NEOTERM_PKG_HOSTBUILD_DIR%g" \
		"$NEOTERM_PKG_SRCDIR"/Makefile.in
}
