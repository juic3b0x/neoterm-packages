# Known issues:
#   https://github.com/neoterm/neoterm-packages/issues/7191
NEOTERM_PKG_HOMEPAGE=https://github.com/vlang/v
NEOTERM_PKG_DESCRIPTION="Simple, fast, safe, compiled language for developing maintainable software"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/vlang/v/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=9152eec96d2eeb575782cf138cb837f315e48c173878857441d98ba679e3a9bf
NEOTERM_PKG_DEPENDS="clang"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="ANDROID=1"

neoterm_step_make_install() {
	install -Dm700 v "$NEOTERM_PREFIX"/libexec/vlang/v
	ln -sfr "$NEOTERM_PREFIX"/libexec/vlang/v "$NEOTERM_PREFIX"/bin/v
	rm -rf "$NEOTERM_PREFIX"/libexec/vlang/vlib
	cp -a cmd vlib "$NEOTERM_PREFIX"/libexec/vlang/
}

