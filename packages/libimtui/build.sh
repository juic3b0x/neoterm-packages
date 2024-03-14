NEOTERM_PKG_HOMEPAGE=https://github.com/ggerganov/imtui
NEOTERM_PKG_DESCRIPTION="An immediate mode text-based user interface library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE, third-party/imgui/imgui/LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/ggerganov/imtui
NEOTERM_PKG_DEPENDS="libc++, ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"

neoterm_step_post_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/hnterm
}
