NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gawk/
NEOTERM_PKG_DESCRIPTION="Programming language designed for text processing"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.3.0"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gawk/gawk-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ca9c16d3d11d0ff8c69d79dc0b47267e1329a69b39b799895604ed447d3ca90b
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libandroid-support, libgmp, libmpfr, readline"
NEOTERM_PKG_BREAKS="gawk-dev"
NEOTERM_PKG_REPLACES="gawk-dev"
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_RM_AFTER_INSTALL="bin/gawk-* bin/igawk share/man/man1/igawk.1"
NEOTERM_PKG_GROUPS="base-devel"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pma
"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# Remove old symlink to force a fresh timestamp:
	rm -f $NEOTERM_PREFIX/bin/awk

	# http://cross-lfs.org/view/CLFS-2.1.0/ppc64-64/temp-system/gawk.html
	cp -v extension/Makefile.in{,.orig}
	sed -e 's/check-recursive all-recursive: check-for-shared-lib-support/check-recursive all-recursive:/' extension/Makefile.in.orig > extension/Makefile.in
}
