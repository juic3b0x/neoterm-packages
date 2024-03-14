NEOTERM_PKG_HOMEPAGE=https://bundles.openttdcoop.org/opensfx
NEOTERM_PKG_DESCRIPTION="Free sound set for openttd"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="license.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.3
NEOTERM_PKG_SRCURL=https://cdn.openttd.org/opensfx-releases/$NEOTERM_PKG_VERSION/opensfx-$NEOTERM_PKG_VERSION-all.zip
NEOTERM_PKG_SHA256=e0a218b7dd9438e701503b0f84c25a97c1c11b7c2f025323fb19d6db16ef3759
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_get_source() {
	neoterm_download \
		"$NEOTERM_PKG_SRCURL" \
		"$NEOTERM_PKG_CACHEDIR/opensfx-$NEOTERM_PKG_VERSION.zip" \
		"$NEOTERM_PKG_SHA256"
	unzip -d "$NEOTERM_PKG_SRCDIR" "$NEOTERM_PKG_CACHEDIR/opensfx-$NEOTERM_PKG_VERSION.zip"

	cd "$NEOTERM_PKG_SRCDIR"
	tar xf "opensfx-$NEOTERM_PKG_VERSION.tar" --strip-components=1
}

neoterm_step_make_install() {
	install -d "$NEOTERM_PREFIX"/share/openttd/data
	install -m600 opensfx.* "$NEOTERM_PREFIX"/share/openttd/data
}
