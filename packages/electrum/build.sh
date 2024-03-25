NEOTERM_PKG_HOMEPAGE=https://electrum.org
NEOTERM_PKG_DESCRIPTION="Electrum is a lightweight Bitcoin wallet"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.5.3"
NEOTERM_PKG_SRCURL=https://download.electrum.org/$NEOTERM_PKG_VERSION/Electrum-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=91e8f49ac73b481fb9d5a779c59ad3f0c304639adf60e1aaba6e913b58011f9b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="python, libsecp256k1, python-pip"
NEOTERM_PKG_PYTHON_TARGET_DEPS="'qrcode', 'protobuf<4,>=3.20', 'qdarkstyle>=2.7', 'aiorpcx<0.23,>=0.22.0', 'aiohttp<4.0.0,>=3.3.0', 'aiohttp_socks>=0.3', 'certifi', 'bitstring', 'attrs>=19.2.0', 'dnspython>=2.0'"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
# asciinema previously contained some files that python packages have in common
NEOTERM_PKG_CONFLICTS="asciinema (<< 1.4.0-1)"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
