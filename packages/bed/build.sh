NEOTERM_PKG_HOMEPAGE="https://github.com/itchyny/bed"
NEOTERM_PKG_DESCRIPTION="Binary editor written in GO"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.2.4"
NEOTERM_PKG_SRCURL="https://github.com/itchyny/bed/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=01d0a28a8e0b66dc73370de2c2b22368ca9c653bf6c7ae4b3bc2f13af42bc788
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true


neoterm_step_make() {
        neoterm_setup_golang
        go build -ldflags="-s -w" -o bed ./cmd/bed
	}

neoterm_step_make_install() {
        install -Dm700 -t $NEOTERM_PREFIX/bin bed
}
