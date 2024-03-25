NEOTERM_PKG_HOMEPAGE=https://github.com/sass/libsass
NEOTERM_PKG_DESCRIPTION="Sass compiler written in C++"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.6.6"
NEOTERM_PKG_SRCURL=https://github.com/sass/libsass/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=11f0bb3709a4f20285507419d7618f3877a425c0131ea8df40fe6196129df15d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	autoreconf -fi

	if [ "${NEOTERM_PKG_SRCURL:0:4}" != "git+" ] && [ ! -e VERSION ]; then
		echo "${NEOTERM_PKG_VERSION#*:}" > VERSION
	fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
