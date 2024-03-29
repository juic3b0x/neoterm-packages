NEOTERM_PKG_HOMEPAGE=https://git.causal.agency/pounce
NEOTERM_PKG_DESCRIPTION="A multi-client, TLS-only IRC bouncer"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1
NEOTERM_PKG_SRCURL=https://git.causal.agency/pounce/snapshot/pounce-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=97f245556b1cc940553fca18f4d7d82692e6c11a30f612415e5e391e5d96604e
NEOTERM_PKG_DEPENDS="libcrypt, libretls"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
"
NEOTERM_PKG_EXTRA_MAKE_ARGS="all"
