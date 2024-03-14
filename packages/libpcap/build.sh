NEOTERM_PKG_HOMEPAGE=https://www.tcpdump.org
NEOTERM_PKG_DESCRIPTION="Library for network traffic capture"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.10.4
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/libpcap-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=bc6fa883db17cf8846de620e591ebc1af2a82fcc5bf7b3d1671d25ef61d9513c
NEOTERM_PKG_BREAKS="libpcap-dev"
NEOTERM_PKG_REPLACES="libpcap-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-pcap=linux --without-libnl"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/pcap-config share/man/man1/pcap-config.1"
