NEOTERM_PKG_HOMEPAGE=https://ninja-build.org
NEOTERM_PKG_DESCRIPTION="A small build system with a focus on speed"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.11.1"
NEOTERM_PKG_SRCURL=https://github.com/ninja-build/ninja/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=31747ae633213f1eda3842686f83c2aa1412e0f5691d1c14dbbcc67fe7400cea
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libandroid-spawn"

neoterm_step_pre_configure() {
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -landroid-spawn"
}

neoterm_step_configure() {
	$NEOTERM_PKG_SRCDIR/configure.py
}

neoterm_step_make() {
	if $NEOTERM_ON_DEVICE_BUILD; then
		$NEOTERM_PKG_SRCDIR/configure.py --bootstrap
	else
		neoterm_setup_ninja
		ninja -j $NEOTERM_MAKE_PROCESSES
	fi
}

neoterm_step_make_install() {
	cp ninja $NEOTERM_PREFIX/bin
}
