NEOTERM_PKG_HOMEPAGE=https://github.com/vapier/ncompress
NEOTERM_PKG_DESCRIPTION="The classic unix compression utility which can handle the ancient .Z archive"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.0
NEOTERM_PKG_SRCURL=https://github.com/vapier/ncompress/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=96ec931d06ab827fccad377839bfb91955274568392ddecf809e443443aead46
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	mkdir -p "$NEOTERM_PREFIX"/share/man/man1/
	install -Dm700 compress "$NEOTERM_PREFIX"/bin/
	install -Dm600 compress.1 "$NEOTERM_PREFIX"/share/man/man1/
}
