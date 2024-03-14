NEOTERM_PKG_HOMEPAGE=https://gitlab.com/volian/nala
NEOTERM_PKG_DESCRIPTION="Commandline frontend for the apt package manager"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.15.1"
NEOTERM_PKG_SRCURL=https://gitlab.com/volian/nala/-/archive/v${NEOTERM_PKG_VERSION}/nala-v${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=04f19bfa94915d5e7ee7c58dadc569cfb3dd311bb8a94c3557655a760e0b7271
NEOTERM_PKG_DEPENDS="python-apt, python-pip"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_PYTHON_COMMON_DEPS="poetry"
NEOTERM_PKG_PYTHON_TARGET_DEPS="anyio, httpx, jsbeautifier, pexpect, python-debian, rich, tomli, typer, typing-extensions"

neoterm_step_pre_configure() {
	rm -rf nala/__init__.py.orig
}

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/etc/nala debian/nala.conf
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/lib/nala
	mkdir -p $NEOTERM_PREFIX/var/log/nala
	mkdir -p $NEOTERM_PREFIX/var/lock
	echo "Installing dependencies through pip..."
	pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
