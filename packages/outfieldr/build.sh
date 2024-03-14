NEOTERM_PKG_HOMEPAGE=https://gitlab.com/ve-nt/outfieldr
NEOTERM_PKG_DESCRIPTION="A TLDR client in Zig"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.3
NEOTERM_PKG_SRCURL=git+https://gitlab.com/ve-nt/outfieldr
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_make() {
	neoterm_setup_zig
	zig build -Dtarget=$ZIG_TARGET_NAME
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/tldr
}
