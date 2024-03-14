NEOTERM_PKG_HOMEPAGE=https://github.com/Akianonymus/gdrive-downloader
NEOTERM_PKG_DESCRIPTION="Download a gdrive folder or file easily, shell ftw"
NEOTERM_PKG_LICENSE="Unlicense"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:1.1
NEOTERM_PKG_SRCURL=https://github.com/Akianonymus/gdrive-downloader/archive/refs/tags/v${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=aa1bf1a0a2cd6cc714292b2e83cf38fa37b99aac8f9d80ee92d619f156ddf4ba
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS='bash, curl'
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	install -D release/bash/* -t "$NEOTERM_PREFIX/bin"
}
