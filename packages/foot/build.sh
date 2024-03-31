NEOTERM_PKG_HOMEPAGE=https://codeberg.org/dnkl/foot
NEOTERM_PKG_DESCRIPTION="Fast, lightweight and minimalistic Wayland terminal emulator"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.16.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://codeberg.org/dnkl/foot/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0e02af376e5f4a96eeb90470b7ad2e79a1d660db2a7d1aa772be43c7db00e475
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, fontconfig, freetype, libfcft, libpixman, libwayland, libxkbcommon, utf8proc"
NEOTERM_PKG_BUILD_DEPENDS="libtllist, libwayland-protocols"

neoterm_step_pre_configure() {
	export PATH="$NEOTERM_PREFIX/opt/libwayland/cross/bin:$PATH"

	# libandroid-support provides this
	export CPPFLAGS+=" -D__STDC_ISO_10646__=201103L"
}
