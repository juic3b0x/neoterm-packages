NEOTERM_PKG_HOMEPAGE="http://git.linux-nfs.org/?p=steved/libtirpc.git"
NEOTERM_PKG_DESCRIPTION="Transport Independent RPC library"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@juic3b0x"
NEOTERM_PKG_VERSION="1.3.4"
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/libtirpc/libtirpc-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=1e0b0c7231c5fa122e06c0609a76723664d068b0dba3b8219b63e6340b347860
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-gssapi"

neoterm_step_post_get_source() {
	sed -i "s/AC_INIT(libtirpc, [^)]*)/AC_INIT(libtirpc, ${NEOTERM_PKG_VERSION##*:})/" configure.ac
}

neoterm_step_pre_configure() {
	aclocal
	automake
	autoconf
}
