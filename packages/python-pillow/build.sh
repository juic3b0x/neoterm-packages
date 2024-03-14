NEOTERM_PKG_HOMEPAGE=https://python-pillow.org/
NEOTERM_PKG_DESCRIPTION="Python Imaging Library"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="10.2.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/python-pillow/Pillow/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fe695f6fa8bbc341b9044b6553a32d84cf6d6ea0de104396aece85e454c7cbc2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="freetype, libimagequant, libjpeg-turbo, libraqm, libtiff, libwebp, libxcb, littlecms, openjpeg, python, zlib"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, 'setuptools==67.8'"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_make_install() {
	if [ ! -e "$NEOTERM_PYTHON_HOME/site-packages/pillow-$NEOTERM_PKG_VERSION.dist-info" ]; then
		neoterm_error_exit "Package ${NEOTERM_PKG_NAME} doesn't build properly."
	fi
}
