NEOTERM_PKG_HOMEPAGE=https://npush.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Curses-based logic game similar to Sokoban and Boulder Dash"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Dmitry Marakasov <amdmi3@amdmi3.ru>"
NEOTERM_PKG_VERSION=0.7
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/npush/npush/${NEOTERM_PKG_VERSION}/npush-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=f216d2b3279e8737784f77d4843c9e6f223fa131ce1ebddaf00ad802aba2bcd9
NEOTERM_PKG_DEPENDS="libc++, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_post_get_source() {
	sed -i -e "s|\"levels|\"${NEOTERM_PREFIX}/share/npush/levels|" npush.cpp
}

neoterm_step_make() {
	$CXX $CXXFLAGS $CPPFLAGS $LDFLAGS -lncurses -o npush npush.cpp
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin/ npush
	install -Dm644 -t $NEOTERM_PREFIX/share/npush/levels levels/* 
}
