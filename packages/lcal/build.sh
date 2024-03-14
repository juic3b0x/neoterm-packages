NEOTERM_PKG_HOMEPAGE=https://pcal.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A multi-platform program which generates PostScript lunar calendars in a yearly format"
# The original calendar PostScript was Copyright (c) 1987 by Patrick Wood
# and Pipeline Associates, Inc. with permission to modify and redistribute.
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="ReadMe.txt, COPYRIGHT.moonphase"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.0
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/pcal/lcal-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=c3c4c2bdec5f5129004385f06960f56bc0e3671ae835ee39044598fb76480f70
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/COPYRIGHT.moonphase ./
}

neoterm_step_make() {
	make CC="$CC"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin ./lcal
	install -Dm700 -T ./lcal.man $NEOTERM_PREFIX/share/man/man1/lcal.1
}
