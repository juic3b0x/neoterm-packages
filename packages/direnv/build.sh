NEOTERM_PKG_HOMEPAGE=https://github.com/direnv/direnv
NEOTERM_PKG_DESCRIPTION="Environment switcher for shell"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.34.0"
NEOTERM_PKG_SRCURL=https://github.com/direnv/direnv/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=3d7067e71500e95d69eac86a271a6b6fc3f2f2817ba0e9a589524bf3e73e007c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang
}
