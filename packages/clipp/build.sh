NEOTERM_PKG_HOMEPAGE=https://github.com/muellan/clipp
NEOTERM_PKG_DESCRIPTION="Command line interfaces for modern C++"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/muellan/clipp/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=73da8e3d354fececdea99f7deb79d0343647349563ace3eafb7f4cca6e86e90b
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/include include/clipp.h
}
