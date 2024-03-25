NEOTERM_PKG_HOMEPAGE=https://www.wireshark.org/
NEOTERM_PKG_DESCRIPTION="Network protocol analyzer and sniffer"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.2.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.wireshark.org/download/src/all-versions/wireshark-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=0e428492f4c3625d61a7ccff008dc0e429d16ab8caccad4403157ea92b48a75b
NEOTERM_PKG_DEPENDS="brotli, c-ares, glib, libandroid-support, libcap, libgcrypt, libgmp, libgnutls, libgpg-error, libiconv, libidn2, liblz4, liblzma, libminizip, libnettle, libnghttp2, libnl, libopus, libpcap, libsnappy, libssh, libunistring, libxml2, openssl, pcre2, speexdsp, zlib, zstd"
NEOTERM_PKG_BREAKS="tshark-dev"
NEOTERM_PKG_REPLACES="tshark-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_wireshark=OFF
-DENABLE_LUA=OFF
-DHAVE_LINUX_IF_BONDING_H=1
"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	gcc $NEOTERM_PKG_SRCDIR/tools/lemon/lemon.c -o lemon
}

neoterm_step_pre_configure() {
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR:$PATH
	LDFLAGS+=" -lm -landroid-support"
	sed -i "s#-T/usr/share/lemon/lempar.c#-T$NEOTERM_PKG_SRCDIR/tools/lemon/lempar.c#" $NEOTERM_PKG_SRCDIR/cmake/modules/UseLemon.cmake
}
