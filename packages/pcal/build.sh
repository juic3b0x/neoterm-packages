NEOTERM_PKG_HOMEPAGE=https://pcal.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A multi-platform program which generates annotated PostScript or HTML calendars in a monthly or yearly format"
# The original calendar PostScript was Copyright (c) 1987 by Patrick Wood
# and Pipeline Associates, Inc. with permission to modify and redistribute.
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="doc/ReadMe.txt, COPYRIGHT.moonphase"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.11.0
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/pcal/pcal-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=8406190e7912082719262b71b63ee31a98face49aa52297db96cc0c970f8d207
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/COPYRIGHT.moonphase ./
}

neoterm_step_make() {
	make CC="$CC"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin ./exec/pcal
	install -Dm700 -T ./doc/pcal.man $NEOTERM_PREFIX/share/man/man1/pcal.1
}
