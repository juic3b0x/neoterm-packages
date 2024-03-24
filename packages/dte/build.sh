TERMUX_PKG_HOMEPAGE='https://craigbarnes.gitlab.io/dte/'
TERMUX_PKG_DESCRIPTION='A small, configurable console text editor'
TERMUX_PKG_LICENSE='GPL-2.0'
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="1.11.1"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://gitlab.com/craigbarnes/dte/-/archive/v${TERMUX_PKG_VERSION}/dte-v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=dec9a7d2a614b60f076ff13fc6e50fe0ea41b68b812a36c69b24a94c3f583608
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libandroid-support, libandroid-glob, libiconv"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	export LDLIBS="-landroid-support -landroid-glob -liconv"
}
