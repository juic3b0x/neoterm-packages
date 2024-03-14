NEOTERM_PKG_HOMEPAGE=https://www.brain-dump.org/projects/abduco/
NEOTERM_PKG_DESCRIPTION="Clean and simple terminal session manager"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://www.brain-dump.org/projects/abduco/abduco-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c90909e13fa95770b5afc3b59f311b3d3d2fdfae23f9569fa4f96a3e192a35f4
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="dvtm"

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}
