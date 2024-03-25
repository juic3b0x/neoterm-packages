NEOTERM_PKG_HOMEPAGE=http://joeyh.name/code/moreutils/
NEOTERM_PKG_DESCRIPTION="A growing collection of the unix tools that nobody thought to write thirty years ago"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.67
NEOTERM_PKG_SRCURL=http://ftp.debian.org/debian/pool/main/m/moreutils/moreutils_$NEOTERM_PKG_VERSION.orig.tar.gz
NEOTERM_PKG_SHA256=03872f42c22943b21c62f711b693c422a4b8df9d1b8b2872ef9a34bd5d13ad10
NEOTERM_PKG_DEPENDS="perl"
NEOTERM_PKG_BUILD_IN_SRC=true

# chronic requires set of external perl modules.
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/chronic
share/man/man1/chronic.1
share/man/man1/parallel.1
"
