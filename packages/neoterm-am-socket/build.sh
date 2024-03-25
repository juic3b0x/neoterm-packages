NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/neoterm-am-socket
NEOTERM_PKG_DESCRIPTION="A faster version of am with less features that only works while NeoTerm is running"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.0
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/neoterm-am-socket/archive/refs/tags/v1.5.0.tar.gz
NEOTERM_PKG_SHA256=b5d0fe2d23af8810609b0d0ccf0549c9299cb7602ee68b1a39dbbe385bd04d48
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_post_get_source() {

	for file in "${NEOTERM_PKG_SRCDIR}/"*; do
		sed -i'' -E -e "s|^(NEOTERM_AM_SOCKET_VERSION=).*|\1$NEOTERM_PKG_FULLVERSION|" \
			-e "s|\@NEOTERM_APP_PACKAGE\@|${NEOTERM_APP_PACKAGE}|g" \
			-e "s|\@NEOTERM_APPS_DIR\@|${NEOTERM_APPS_DIR}|g" \
			"$file"
	done

}
