NEOTERM_PKG_HOMEPAGE=http://net-tools.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Configuration tools for Linux networking"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.10.0
NEOTERM_PKG_SRCURL=https://sourceforge.net/projects/net-tools/files/net-tools-2.10.tar.xz
NEOTERM_PKG_SHA256=b262435a5241e89bfa51c3cabd5133753952f7a7b7b93f32e08cb9d96f580d69
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="BINDIR=$NEOTERM_PREFIX/bin SBINDIR=$NEOTERM_PREFIX/bin HAVE_HOSTNAME_TOOLS=0"

neoterm_step_configure() {
	CFLAGS="$CFLAGS -D_LINUX_IN6_H -Dindex=strchr -Drindex=strrchr"
	sed -i "s#/usr#$NEOTERM_PREFIX#" $NEOTERM_PKG_SRCDIR/man/Makefile
	yes "" | make config || true
}
