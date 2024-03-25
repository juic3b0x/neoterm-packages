NEOTERM_PKG_HOMEPAGE=https://bundles.openttdcoop.org/openmsx
NEOTERM_PKG_DESCRIPTION="Free music set for openttd"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.2
NEOTERM_PKG_SRCURL=https://cdn.openttd.org/openmsx-releases/$NEOTERM_PKG_VERSION/openmsx-$NEOTERM_PKG_VERSION-all.zip
NEOTERM_PKG_SHA256=5a4277a2e62d87f2952ea5020dc20fb2f6ffafdccf9913fbf35ad45ee30ec762
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_get_source() {
	neoterm_download \
		"$NEOTERM_PKG_SRCURL" \
		"$NEOTERM_PKG_CACHEDIR/openmsx-$NEOTERM_PKG_VERSION.zip" \
		"$NEOTERM_PKG_SHA256"
	unzip -d "$NEOTERM_PKG_SRCDIR" "$NEOTERM_PKG_CACHEDIR/openmsx-$NEOTERM_PKG_VERSION.zip"

	cd "$NEOTERM_PKG_SRCDIR"
	tar xf "openmsx-$NEOTERM_PKG_VERSION.tar" --strip-components=1
}

neoterm_step_make_install() {
	install -d "$NEOTERM_PREFIX"/share/openttd/data
	install -m600 openmsx.obm "$NEOTERM_PREFIX"/share/openttd/data
	install -m600 *.mid "$NEOTERM_PREFIX"/share/openttd/data
}
