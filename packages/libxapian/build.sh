NEOTERM_PKG_HOMEPAGE=https://xapian.org
NEOTERM_PKG_DESCRIPTION="Xapian search engine library"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.25"
NEOTERM_PKG_SRCURL=https://oligarchy.co.uk/xapian/${NEOTERM_PKG_VERSION}/xapian-core-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=0c99dfdd817571cb5689bc412a7e021407938313f38ea3a70fa3bf86410608ee
NEOTERM_PKG_AUTO_UPDATE=true
# Note that we cannot /proc/sys/kernel/random/uuid (permission denied on
# new android versions) so need libuuid.
NEOTERM_PKG_DEPENDS="libc++, libuuid, zlib"
NEOTERM_PKG_BREAKS="libxapian-dev"
NEOTERM_PKG_REPLACES="libxapian-dev"
NEOTERM_PKG_RM_AFTER_INSTALL="
share/doc/xapian-core/
"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
