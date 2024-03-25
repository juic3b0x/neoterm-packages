NEOTERM_PKG_HOMEPAGE=https://gitlab.com/cryptsetup/cryptsetup/
NEOTERM_PKG_DESCRIPTION="Userspace setup tool for transparent encryption of block devices using dm-crypt"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.1
NEOTERM_PKG_SRCURL=https://mirrors.edge.kernel.org/pub/linux/utils/cryptsetup/v${NEOTERM_PKG_VERSION:0:3}/cryptsetup-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=410ded65a1072ab9c8e41added37b9729c087fef4d2db02bb4ef529ad6da4693
NEOTERM_PKG_DEPENDS="json-c, libblkid, libdevmapper, libgcrypt, libuuid, openssl, libiconv, argon2"
NEOTERM_PKG_BREAKS="cryptsetup-dev, cryptsetup (<< 2.4.3-1)"
NEOTERM_PKG_REPLACES="cryptsetup-dev, cryptsetup (<< 2.4.3-1)"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-luks2-lock-path=$NEOTERM_PREFIX/var/run
--enable-libargon2
--disable-ssh-token
"

neoterm_step_pre_configure() {
	export LDFLAGS+=" -liconv"
}
