NEOTERM_PKG_HOMEPAGE=https://github.com/raboof/nethogs
NEOTERM_PKG_DESCRIPTION="Net top tool grouping bandwidth per process"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.7
NEOTERM_PKG_SRCURL=https://github.com/raboof/nethogs/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=957d6afcc220dfbba44c819162f44818051c5b4fb793c47ba98294393986617d
NEOTERM_PKG_DEPENDS="libc++, ncurses, libpcap"
NEOTERM_PKG_EXTRA_MAKE_ARGS="nethogs"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	mv pyproject.toml{,.unused}
	mv setup.py{,.unused}
}

neoterm_step_pre_configure() {
	CPPFLAGS+=" -Dindex=strchr -Drindex=strrchr -Dquad_t=int64_t"
}
