NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/bc/
NEOTERM_PKG_DESCRIPTION="Arbitrary precision numeric processing language"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.07.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/bc/bc-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc46daf9931cf4942664cb02a
NEOTERM_PKG_DEPENDS="readline,flex"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--infodir=$NEOTERM_PREFIX/share/info
--mandir=$NEOTERM_PREFIX/share/man
--with-readline
"

neoterm_step_pre_configure() {
	cp $NEOTERM_PKG_HOSTBUILD_DIR/bc/libmath.h \
	   $NEOTERM_PKG_SRCDIR/bc/libmath.h
	touch -d "next hour" $NEOTERM_PKG_SRCDIR/bc/libmath.h
}
