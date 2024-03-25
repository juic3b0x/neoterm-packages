NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/cpio/
NEOTERM_PKG_DESCRIPTION="CPIO implementation from the GNU project"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.14
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/cpio/cpio-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=fcdc15d60f7267a6fc7efcd6b9db7b6c8966c4f2fbbb964c24d41336fd3f2c12
NEOTERM_PKG_DEPENDS="tar"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-rmt=$NEOTERM_PREFIX/libexec/rmt"

neoterm_step_pre_configure() {
	autoreconf -fi
}
