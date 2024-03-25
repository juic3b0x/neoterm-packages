NEOTERM_PKG_HOMEPAGE=https://packages.debian.org/sid/adwaita-icon-theme
NEOTERM_PKG_DESCRIPTION="Legacy icons for adwaita-icon-theme"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=43
_DEBIAN_REVISION=1
NEOTERM_PKG_SRCURL=(https://deb.debian.org/debian/pool/main/a/adwaita-icon-theme/adwaita-icon-theme_${NEOTERM_PKG_VERSION}.orig-41.tar.xz
                   https://deb.debian.org/debian/pool/main/a/adwaita-icon-theme/adwaita-icon-theme_${NEOTERM_PKG_VERSION}-${_DEBIAN_REVISION}.debian.tar.xz)
NEOTERM_PKG_SHA256=(ef5339d8c35fcad5d10481b70480803f0fa20b3d3cbc339238fcaceeaee01eba
                   fd0027aaec8b6aa8561eda51d82e3b634c1bfe668e233692afa8ffc66a4170bb)
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_DEPENDS="adwaita-icon-theme"

neoterm_step_pre_configure() {
	DESTDIR=$NEOTERM_PKG_BUILDDIR/_destdir
	NEOTERM_PKG_EXTRA_MAKE_ARGS+=" DESTDIR=$DESTDIR"
}

neoterm_step_post_make_install() {
	python3 $NEOTERM_PKG_SRCDIR/debian/move-subset.py \
		--icon-names-from-file=$NEOTERM_PKG_SRCDIR/debian/legacy-icons-41.txt \
		--icon-names-from-file=$NEOTERM_PKG_SRCDIR/debian/removed-icons-41.txt \
		$DESTDIR/$NEOTERM_PREFIX \
		$NEOTERM_PREFIX
}
