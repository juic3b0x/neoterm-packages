NEOTERM_PKG_HOMEPAGE=http://www.andre-simon.de/doku/ansifilter/en/ansifilter.php
NEOTERM_PKG_DESCRIPTION="Strip or convert ANSI codes into HTML, (La)Tex, RTF, or BBCode"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.20
NEOTERM_PKG_SRCURL=git+https://gitlab.com/saalen/ansifilter
NEOTERM_PKG_GIT_BRANCH="$NEOTERM_PKG_VERSION"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_MAKE_ARGS="
DESTDIR=${NEOTERM_PREFIX}
PREFIX=
"
