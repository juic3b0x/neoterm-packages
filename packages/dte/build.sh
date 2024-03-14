NEOTERM_PKG_HOMEPAGE='https://craigbarnes.gitlab.io/dte/'
NEOTERM_PKG_DESCRIPTION='A small, configurable console text editor'
NEOTERM_PKG_LICENSE='GPL-2.0'
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.11.1"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://gitlab.com/craigbarnes/dte/-/archive/v${NEOTERM_PKG_VERSION}/dte-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=68c25bc4e8792da33529626e23102cd5fb34186479049f5480fd9f3e9ffb1171
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libandroid-glob, libiconv"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export LDLIBS="-landroid-support -landroid-glob -liconv"
}
