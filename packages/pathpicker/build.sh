NEOTERM_PKG_HOMEPAGE=https://facebook.github.io/PathPicker/
NEOTERM_PKG_DESCRIPTION="Facebook PathPicker - a terminal-based file picker"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/facebook/PathPicker/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b0142676ed791085d619d9b3d28d28cab989ffc3b260016766841c70c97c2a52
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="bash,python"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	_PKG_DIR=$NEOTERM_PREFIX/share/pathpicker
	rm -Rf $_PKG_DIR src/tests
	mkdir -p $_PKG_DIR
	cp -Rf src/ $_PKG_DIR
	cp fpp $_PKG_DIR/fpp
	cd $NEOTERM_PREFIX/bin
	ln -f -s ../share/pathpicker/fpp fpp
	chmod +x fpp
}
