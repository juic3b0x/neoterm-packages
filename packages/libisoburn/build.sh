NEOTERM_PKG_HOMEPAGE=https://dev.lovelyhq.com/libburnia
NEOTERM_PKG_DESCRIPTION="Frontend for libraries libburn and libisofs"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.6
NEOTERM_PKG_SRCURL=https://files.libburnia-project.org/releases/libisoburn-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=2b80a6f73dd633a5d243facbe97a15e5c9a07644a5e1a242c219b9375a45f71b
NEOTERM_PKG_DEPENDS="libburn, libisofs, readline"
NEOTERM_PKG_CONFLICTS="xorriso"
NEOTERM_PKG_BREAKS="libisoburn-dev"
NEOTERM_PKG_REPLACES="libisoburn-dev"

# We don't have tk.
NEOTERM_PKG_RM_AFTER_INSTALL="bin/xorriso-tcltk"
