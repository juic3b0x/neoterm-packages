NEOTERM_PKG_HOMEPAGE=http://gondor.apana.org.au/~herbert/dash/
NEOTERM_PKG_DESCRIPTION="Small POSIX-compliant implementation of /bin/sh"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5.12
NEOTERM_PKG_SRCURL=http://gondor.apana.org.au/~herbert/dash/files/dash-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6a474ac46e8b0b32916c4c60df694c82058d3297d8b385b74508030ca4a8f28a
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-static"

neoterm_step_post_make_install() {
	# Symlink sh -> dash
	ln -sfr $NEOTERM_PREFIX/bin/{dash,sh}
	ln -sfr $NEOTERM_PREFIX/share/man/man1/{dash,sh}.1
}
