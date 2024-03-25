NEOTERM_PKG_HOMEPAGE=https://github.com/tLDP/python-tldp
NEOTERM_PKG_DESCRIPTION="Tools for publishing from TLDP sources"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.5
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/tLDP/python-tldp/archive/refs/tags/tldp-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bae313095b877b4272ddccaabd70efcbc526e2c1036f63fb665ec7ce10c94cde
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="python, python-pip"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_PYTHON_TARGET_DEPS="networkx, nose"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
