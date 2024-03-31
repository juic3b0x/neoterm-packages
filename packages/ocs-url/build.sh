NEOTERM_PKG_HOMEPAGE=https://www.opendesktop.org/p/1136805/
NEOTERM_PKG_DESCRIPTION="An install helper program for items served via OpenCollaborationServices (ocs://)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://www.opencode.net/dfn2/ocs-url
NEOTERM_PKG_GIT_BRANCH=release-${NEOTERM_PKG_VERSION}
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtdeclarative, qt5-qtsvg"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
PREFIX=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	./scripts/prepare
}

neoterm_step_configure() {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
		${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS}
}

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME \
		$NEOTERM_PKG_SRCDIR/README.md
}
