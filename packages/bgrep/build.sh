NEOTERM_PKG_HOMEPAGE=https://debugmo.de/2009/04/bgrep-a-binary-grep/
NEOTERM_PKG_DESCRIPTION="Binary string grep tool"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/rsharo/bgrep/archive/bgrep-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ba5ddae672e84bf2d8ce91429a4ce8a5e3a154ee7e64d1016420f7dc7481ec0a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	./bootstrap
}
