NEOTERM_PKG_HOMEPAGE=https://neoterm.org
NEOTERM_PKG_DESCRIPTION="Contains LICENSE files for common licenses"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_ESSENTIAL=true

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/LICENSES
	for LICENSE in "$NEOTERM_PKG_BUILDER_DIR/LICENSES/*.txt"; do
		cp -f $LICENSE $NEOTERM_PREFIX/share/LICENSES/
	done
}
