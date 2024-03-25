NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/neoterm-am-socket
NEOTERM_PKG_DESCRIPTION="A faster version of am with less features that only works while NeoTerm is running"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.0
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/neoterm-am-socket/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5175023c7fd675492451a72d06b75c772f257685b69fe117227bae5a5e6f5494
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_post_get_source() {

	for file in "${NEOTERM_PKG_SRCDIR}/"*; do
		sed -i'' -E -e "s|^(NEOTERM_AM_SOCKET_VERSION=).*|\1$NEOTERM_PKG_FULLVERSION|" \
			-e "s|\@NEOTERM_APP_PACKAGE\@|${NEOTERM_APP_PACKAGE}|g" \
			-e "s|\@NEOTERM_APPS_DIR\@|${NEOTERM_APPS_DIR}|g" \
			"$file"
	done

}
