NEOTERM_PKG_HOMEPAGE=https://strace.io/
NEOTERM_PKG_DESCRIPTION="Debugging utility to monitor system calls and signals received"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_LICENSE_FILE="COPYING, LGPL-2.1-or-later"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.7"
NEOTERM_PKG_SRCURL=https://github.com/strace/strace/releases/download/v$NEOTERM_PKG_VERSION/strace-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=2090201e1a3ff32846f4fe421c1163b15f440bb38e31355d09f82d3949922af7
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libdw"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-libdw
"

# This is a perl script.
NEOTERM_PKG_RM_AFTER_INSTALL="bin/strace-graph"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = "arm" ] || [ "$NEOTERM_ARCH" = "i686" ] || [ "$NEOTERM_ARCH" = "x86_64" ]; then
		# Without st_cv_m32_mpers=no the build fails if gawk is installed.
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" st_cv_m32_mpers=no"
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-mpers=no"
	fi
	autoreconf # for configure.ac in configure-find-armv7-cc.patch
	CPPFLAGS+=" -Dfputs_unlocked=fputs"
}
