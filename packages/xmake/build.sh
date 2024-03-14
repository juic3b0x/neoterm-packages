NEOTERM_PKG_HOMEPAGE=https://xmake.io/
NEOTERM_PKG_DESCRIPTION="A cross-platform build utility based on Lua"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="Ruki Wang @waruqi"
NEOTERM_PKG_VERSION="2.8.8"
NEOTERM_PKG_SRCURL=https://github.com/xmake-io/xmake/releases/download/v${NEOTERM_PKG_VERSION}/xmake-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=50916540995e3b9f4ad71af71b2d1987be754a468d1b3199c44e425b232fd0a3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure () {
	$NEOTERM_PKG_SRCDIR/configure --prefix=$NEOTERM_PREFIX
}
