NEOTERM_PKG_HOMEPAGE=https://hewlettpackard.github.io/wireless-tools/Tools
NEOTERM_PKG_DESCRIPTION="A set of tools allowing to manipulate the Wireless Extensions"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=30pre9
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://hewlettpackard.github.io/wireless-tools/wireless_tools.30.pre9.tar.gz
NEOTERM_PKG_SHA256=abd9c5c98abf1fdd11892ac2f8a56737544fe101e1be27c6241a564948f34c63
NEOTERM_PKG_BREAKS="wireless-tools-dev"
NEOTERM_PKG_REPLACES="wireless-tools-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make () {
	make \
		CC="$CC" \
		CFLAGS="$CFLAGS $CPPFLAGS -fPIE -pie" \
		LDFLAGS="$LDFLAGS -fPIE -pie" \
		PREFIX="${NEOTERM_PREFIX}"
}
