NEOTERM_PKG_HOMEPAGE=https://github.com/kdabir/has
NEOTERM_PKG_DESCRIPTION="has checks presence of various command line tools and their versions on the path"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.5.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=$NEOTERM_PKG_HOMEPAGE/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=d45be15f234556cdbaffa46edae417b214858a4bd427a44a2a94aaa893da7d99
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="bash, ncurses-utils"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make() {
	return
}

neoterm_step_make_install() {
	local bin="$(basename $NEOTERM_PKG_HOMEPAGE)"
	install -D "$bin" -t "$NEOTERM_PREFIX/bin"
}
