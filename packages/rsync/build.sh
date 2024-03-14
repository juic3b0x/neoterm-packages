NEOTERM_PKG_HOMEPAGE=https://rsync.samba.org/
NEOTERM_PKG_DESCRIPTION="Utility that provides fast incremental file transfer"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.2.7
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://rsync.samba.org/ftp/rsync/src/rsync-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4e7d9d3f6ed10878c58c5fb724a67dacf4b6aac7340b13e488fb2dc41346f2bb
NEOTERM_PKG_DEPENDS="libiconv, liblz4, libpopt, openssh | dropbear, openssl, openssl-tool, xxhash, zlib, zstd"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-rsyncd-conf=$NEOTERM_PREFIX/etc/rsyncd.conf
--with-included-popt=no
--with-included-zlib=no
--enable-ipv6=yes
--disable-debug
--disable-simd
--disable-xattr-support
--enable-xxhash
"
