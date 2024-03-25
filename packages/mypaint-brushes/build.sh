NEOTERM_PKG_HOMEPAGE=https://github.com/mypaint/mypaint-brushes
NEOTERM_PKG_DESCRIPTION="MyPaint brushes"
NEOTERM_PKG_LICENSE="CC0-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.2
NEOTERM_PKG_SRCURL=https://github.com/mypaint/mypaint-brushes/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=01032550dd817bb0f8e85d83a632ed2e50bc16e0735630839e6c508f02f800ac
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_pre_configure() {
	autoreconf -fi
}
