NEOTERM_PKG_HOMEPAGE=https://github.com/smxi/inxi
NEOTERM_PKG_DESCRIPTION="Full featured CLI system information tool"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.31-2"
NEOTERM_PKG_SRCURL=https://github.com/smxi/inxi/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ff5d138392ac557e31ede6cf96d73d1b9f972f42f6529d47fec2c51184bff338
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="perl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin/ inxi
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1/ inxi.1
}
