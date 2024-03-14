NEOTERM_PKG_HOMEPAGE=https://github.com/wg/wrk
NEOTERM_PKG_DESCRIPTION="Modern HTTP benchmarking tool"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.2.0
NEOTERM_PKG_SRCURL=https://github.com/wg/wrk/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e255f696bff6e329f5d19091da6b06164b8d59d62cb9e673625bdcd27fe7bdad
NEOTERM_PKG_DEPENDS="openssl, luajit"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_make() {
	local _ARCH

	if [ "$NEOTERM_ARCH" = "i686" ]; then
		_ARCH="x86"
	elif [ "$NEOTERM_ARCH" = "x86_64" ]; then
		_ARCH="x64"
	elif [ "$NEOTERM_ARCH" = "aarch64" ]; then
		_ARCH="arm64"
	else
		_ARCH=$NEOTERM_ARCH
	fi

	make WITH_OPENSSL=$NEOTERM_PREFIX WITH_LUAJIT=$NEOTERM_PREFIX _ARCH=$_ARCH
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin wrk
	install -Dm600 -t "$NEOTERM_PREFIX"/share/doc/wrk/examples/ scripts/*.lua
	install -Dm600 -t "$NEOTERM_PREFIX"/share/lua/5.1/ src/wrk.lua
}
