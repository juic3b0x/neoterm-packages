NEOTERM_PKG_HOMEPAGE=https://www.airs.com/ian/uucp.html
NEOTERM_PKG_DESCRIPTION="The standard UUCP package of the Free Software Foundation"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.07
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=ftp://ftp.gnu.org/pub/gnu/uucp/uucp-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=060c15bfba6cfd1171ad81f782789032113e199a5aded8f8e0c1c5bd1385b62c
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--infodir=$NEOTERM_PREFIX/share/info
--mandir=$NEOTERM_PREFIX/share/man
"
