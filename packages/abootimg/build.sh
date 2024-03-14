NEOTERM_PKG_HOMEPAGE=https://gitlab.com/ajs124/abootimg
NEOTERM_PKG_DESCRIPTION="Pack or unpack android boot images"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://gitlab.com/ajs124/abootimg/-/archive/v${NEOTERM_PKG_VERSION}/abootimg-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1dde5cadb8a14fccc677e5422d32c969a49c705daa03ce9b69af941247ff7cde
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="util-linux, libblkid"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source () {
	echo "#define VERSION_STR \"$NEOTERM_PKG_VERSION\"" > $NEOTERM_PKG_SRCDIR/version.h
	touch -d "next hour" $NEOTERM_PKG_SRCDIR/version.h
}
