NEOTERM_PKG_HOMEPAGE="https://github.com/tareksander/neoterm-gui-pm"
NEOTERM_PKG_DESCRIPTION="A graphical package manager for various package formats for NeoTerm and proot-distro distros"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@tareksander"
NEOTERM_PKG_VERSION="1.0.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_DEPENDS="python, python-pip"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SRCURL="https://github.com/tareksander/neoterm-gui-pm/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256="3a5a829b721d17f2002406571852e63d1984acc9732e58f2f76a2966381297c6"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_PYTHON_TARGET_DEPS="neotermgui"

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${NEOTERM_PREFIX}/bin/sh
	echo "Installing python bindings for NeoTerm:GUI"
	pip3 install --upgrade $NEOTERM_PKG_PYTHON_TARGET_DEPS
	EOF
}
 
