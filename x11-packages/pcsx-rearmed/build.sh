NEOTERM_PKG_HOMEPAGE=https://github.com/notaz/pcsx_rearmed
NEOTERM_PKG_DESCRIPTION="Yet another PCSX fork based on the PCSX-Reloaded project"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=23
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=git+https://github.com/notaz/pcsx_rearmed
NEOTERM_PKG_GIT_BRANCH=r${NEOTERM_PKG_VERSION}
NEOTERM_PKG_SHA256=887e9b5ee7b8115d35099c730372b4158fd3e215955a06d68e20928b339646af
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libpng, opengl, pulseaudio, sdl, zlib"
NEOTERM_PKG_BUILD_DEPENDS="binutils-cross"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_pkg_auto_update() {
	# Get latest release tag:
	local tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	if grep -qP "^r\d+\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a release ($tag)"
	fi
}

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	if [ "$NEOTERM_ARCH" = "arm" ]; then
		neoterm_setup_no_integrated_as
	fi
}

neoterm_step_configure() {
	sh ./configure
}

neoterm_step_make_install() {
	install -Dm755 pcsx $NEOTERM_PREFIX/bin/pcsx
	mkdir -p $NEOTERM_PREFIX/etc/pcsx $NEOTERM_PREFIX/lib/pcsx_plugins
	cp -r frontend/pandora/skin $NEOTERM_PREFIX/etc/pcsx/
	install -m755 plugins/*.so $NEOTERM_PREFIX/lib/pcsx_plugins/
	ln -fs ../../lib/pcsx_plugins $NEOTERM_PREFIX/etc/pcsx/plugins
}
