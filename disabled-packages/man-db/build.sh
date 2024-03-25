NEOTERM_PKG_HOMEPAGE=https://www.nongnu.org/man-db/
NEOTERM_PKG_DESCRIPTION="Utilities for examining on-line help files (manual pages)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.7.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.savannah.nongnu.org/releases/man-db/man-db-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5c4ddd0d67abbbcb408dc5804906f62210f7c863ef791198faca3d75681cca14
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-db=gdbm --with-pager=less --with-config-file=${NEOTERM_PREFIX}/etc/man_db.conf --disable-setuid --with-browser=lynx --with-gzip=gzip --with-systemdtmpfilesdir=${NEOTERM_PREFIX}/lib/tmpfiles.d"
NEOTERM_PKG_DEPENDS="flex, gdbm, groff, less, libandroid-support, libpipeline, lynx"

export GROFF_TMAC_PATH="${NEOTERM_PREFIX}/lib/groff/site-tmac:${NEOTERM_PREFIX}/share/groff/site-tmac:${NEOTERM_PREFIX}/share/groff/current/tmac"
