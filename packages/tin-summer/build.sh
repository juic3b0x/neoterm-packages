NEOTERM_PKG_HOMEPAGE=https://github.com/vmchale/tin-summer
NEOTERM_PKG_DESCRIPTION="Find build artifacts that are taking up disk space"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.21.14
NEOTERM_PKG_SRCURL=https://github.com/vmchale/tin-summer/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=8a4883b7a6354c6340e73a87d1009c0cc79bdfa135fe947317705dad9f0a6727
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	sed -i 's/linux/android/g' src/utils.rs
}
