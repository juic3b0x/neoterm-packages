NEOTERM_PKG_HOMEPAGE=https://github.com/jarun/bcal
NEOTERM_PKG_DESCRIPTION="Command-line utility for storage conversions and calculations"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@fervi"
NEOTERM_PKG_VERSION="2.4"
NEOTERM_PKG_SRCURL=https://github.com/jarun/bcal/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=141f39d866f62274b2262164baaac6202f60749862c84c2e6ed231f6d03ee8df
NEOTERM_PKG_DEPENDS="readline, bc"
NEOTERM_PKG_BUILD_IN_SRC=true

# 64-bit archs only, check https://github.com/jarun/bcal/issues/4
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"
