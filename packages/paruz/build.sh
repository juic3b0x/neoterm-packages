NEOTERM_PKG_HOMEPAGE=https://github.com/joehillen/paruz
NEOTERM_PKG_DESCRIPTION="A fzf terminal UI for paru or pacman"
NEOTERM_PKG_LICENSE="Unlicense"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.2
NEOTERM_PKG_SRCURL=https://github.com/joehillen/paruz/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1800e55136b2c17135a7139ae3f3f4706c60d23b957b9a92cb1d3bf2d5942123
NEOTERM_PKG_DEPENDS="bash, fzf"
NEOTERM_PKG_RECOMMENDS="pacman"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin paruz
}
