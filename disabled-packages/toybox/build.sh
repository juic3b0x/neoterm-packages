NEOTERM_PKG_HOMEPAGE=https://landley.net/toybox/
NEOTERM_PKG_DESCRIPTION="Common Linux command line utilities"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.3
NEOTERM_PKG_SRCURL=https://landley.net/toybox/downloads/toybox-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e6469b508224e0d2e4564dda05c4bb47aef5c28bf29d6c983bcdc6e3a0cd29d6
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	make defconfig
}
