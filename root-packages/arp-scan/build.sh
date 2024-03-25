NEOTERM_PKG_HOMEPAGE=https://github.com/royhills/arp-scan
NEOTERM_PKG_DESCRIPTION="arp-scan is a command-line tool for system discovery and fingerprinting. It constructs and sends ARP requests to the specified IP addresses, and displays any responses that are received."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.10.0
NEOTERM_PKG_SRCURL=https://github.com/royhills/arp-scan/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=204b13487158b8e46bf6dd207757a52621148fdd1d2467ebd104de17493bab25
NEOTERM_PKG_DEPENDS="libpcap"

if [[ ${NEOTERM_ARCH_BITS} == 32 ]]; then
	# Retrieved from compilation on device:
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="pgac_cv_snprintf_long_long_int_format=%lld"
fi

neoterm_step_pre_configure () {
	cp ${NEOTERM_PKG_BUILDER_DIR}/hsearch/* ${NEOTERM_PKG_SRCDIR}/
	autoreconf -fi
}
