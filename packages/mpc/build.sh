NEOTERM_PKG_HOMEPAGE=https://www.musicpd.org/clients/mpc/
NEOTERM_PKG_DESCRIPTION="Minimalist command line interface for MPD"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.35
NEOTERM_PKG_SRCURL=https://www.musicpd.org/download/mpc/${NEOTERM_PKG_VERSION:0:1}/mpc-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=382959c3bfa2765b5346232438650491b822a16607ff5699178aa1386e3878d4
NEOTERM_PKG_DEPENDS="libiconv, libmpdclient"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-Diconv=enabled"

# There seems to be issues with sphinx-build when using concurrent builds:
NEOTERM_MAKE_PROCESSES=1

neoterm_step_pre_configure() {
	LDFLAGS+=" -liconv"
}
