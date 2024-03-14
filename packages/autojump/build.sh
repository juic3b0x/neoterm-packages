NEOTERM_PKG_HOMEPAGE=https://github.com/wting/autojump
NEOTERM_PKG_DESCRIPTION="A faster way to navigate your filesystem"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=22.5.3
NEOTERM_PKG_SRCURL=https://github.com/wting/autojump/archive/refs/tags/release-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=00daf3698e17ac3ac788d529877c03ee80c3790472a85d0ed063ac3a354c37b1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="python"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	:
}

neoterm_step_make_install() {
	SHELL=/bin/bash ./install.py --system
}
