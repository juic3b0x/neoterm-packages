NEOTERM_PKG_HOMEPAGE=https://tildegit.org/tomasino/pb
NEOTERM_PKG_DESCRIPTION="A helper utility for using 0x0 pastebin services"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2022.11.03
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/jamestomasino/pb/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e76ca01fe77392695a43ef7ea9c27b3e89b7e2af5750d41b35916e1fd1d66098
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

neoterm_step_make() {
	:
}
