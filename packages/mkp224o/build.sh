NEOTERM_PKG_HOMEPAGE=https://github.com/cathugger/mkp224o
NEOTERM_PKG_DESCRIPTION="Generate vanity ed25519 (hidden service version 3) onion addresses"
NEOTERM_PKG_LICENSE="CC0-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.0"
NEOTERM_PKG_SRCURL=https://github.com/cathugger/mkp224o/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e7bda8517206a1786d97c793a2b7ad91be88e73ed2e7d9aad986f3bd5e3fdb5e
NEOTERM_PKG_DEPENDS="libsodium"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	autoconf -f

	# configure scripts tries to get version from git, or this file:
	echo "v$NEOTERM_PKG_VERSION" > $NEOTERM_PKG_SRCDIR/version.txt
}

neoterm_step_make_install() {
	install -m700 mkp224o $NEOTERM_PREFIX/bin/
}
