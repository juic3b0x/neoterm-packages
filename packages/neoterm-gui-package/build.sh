NEOTERM_PKG_HOMEPAGE="https://github.com/tareksander/neoterm-gui-package"
NEOTERM_PKG_DESCRIPTION="A Termux package containing utilities for Termux:GUI"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@tareksander"
NEOTERM_PKG_VERSION="0.1.6"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_DEPENDS="python, python-pip"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SRCURL="https://github.com/tareksander/neoterm-gui-package/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256="79a231f6550bde39c0bdd4eca0fce91b21df9c817345072c4859567437e485bf"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_PYTHON_TARGET_DEPS="neotermgui"

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${NEOTERM_PREFIX}/bin/sh
	echo "Installing python bindings for Termux:GUI"
	pip3 install --upgrade $NEOTERM_PKG_PYTHON_TARGET_DEPS
	EOF
}
