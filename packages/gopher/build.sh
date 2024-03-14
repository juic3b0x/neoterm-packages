NEOTERM_PKG_HOMEPAGE=gopher://gopher.quux.org/1/devel/gopher
NEOTERM_PKG_DESCRIPTION="University of Minnesota gopher"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.0.17.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=http://archive.ubuntu.com/ubuntu/pool/universe/g/gopher/gopher_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=584b4ffeaa5221bab94bc4934b644f64df35c955e7720f3cfff648072eb0370b
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
"

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lncursesw"
}
