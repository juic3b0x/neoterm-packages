NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/sharutils/
NEOTERM_PKG_DESCRIPTION="Utilities for packaging and unpackaging shell archives"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.15.2
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/sharutils/sharutils-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=2b05cff7de5d7b646dc1669bc36c35fdac02ac6ae4b6c19cb3340d87ec553a9a
NEOTERM_PKG_DEPENDS="libandroid-support"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_spawn_h=no
"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"
}
