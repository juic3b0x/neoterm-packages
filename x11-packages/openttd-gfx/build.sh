NEOTERM_PKG_HOMEPAGE=https://dev.openttdcoop.org/projects/opengfx
NEOTERM_PKG_DESCRIPTION="A free graphics set for openttd"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.1
NEOTERM_PKG_SRCURL=https://cdn.openttd.org/opengfx-releases/$NEOTERM_PKG_VERSION/opengfx-$NEOTERM_PKG_VERSION-all.zip
NEOTERM_PKG_SHA256=928fcf34efd0719a3560cbab6821d71ce686b6315e8825360fba87a7a94d7846
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_get_source() {
	neoterm_download \
		"$NEOTERM_PKG_SRCURL" \
		"$NEOTERM_PKG_CACHEDIR/opengfx-$NEOTERM_PKG_VERSION.zip" \
		"$NEOTERM_PKG_SHA256"
	unzip -d "$NEOTERM_PKG_SRCDIR" "$NEOTERM_PKG_CACHEDIR/opengfx-$NEOTERM_PKG_VERSION.zip"

	cd "$NEOTERM_PKG_SRCDIR"
	tar xf "opengfx-$NEOTERM_PKG_VERSION.tar" --strip-components=1
}

neoterm_step_make_install() {
	install -d "$NEOTERM_PREFIX"/share/openttd/data
	install -m600 *.grf "$NEOTERM_PREFIX"/share/openttd/data
	install -m600 *.obg "$NEOTERM_PREFIX"/share/openttd/data
}
