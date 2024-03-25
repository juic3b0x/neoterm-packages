NEOTERM_PKG_HOMEPAGE="https://github.com/michaelforney/samurai"
NEOTERM_PKG_DESCRIPTION="ninja-compatible build tool written in C"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2"
NEOTERM_PKG_SRCURL="https://github.com/michaelforney/samurai/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=37a2d9f35f338c53387eba210bab7e5d8abe033492664984704ad84f91b71bac
NEOTERM_PKG_DEPENDS="libandroid-spawn"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	rm -f "build.ninja"
	export LDFLAGS+=" -landroid-spawn"
}
