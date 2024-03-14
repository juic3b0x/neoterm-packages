NEOTERM_PKG_HOMEPAGE=https://docs.iyear.me/tdl/
NEOTERM_PKG_DESCRIPTION="Telegram downloader/tools written in Golang"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.16.1"
NEOTERM_PKG_SRCURL=https://github.com/iyear/tdl/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=b701f1cb51b906b25f19e811f30115bd6c624fc5339569baa5819be3a6a34d4a
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin tdl
}
