NEOTERM_PKG_HOMEPAGE=https://github.com/zlin/wgetpaste
NEOTERM_PKG_DESCRIPTION="wgetpaste is a shell script that allows its users to upload log."
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.33
NEOTERM_PKG_SRCURL=https://github.com/zlin/wgetpaste/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b32a283c84dc7b35b3a803ac330c7f13a2faef404809139e3ac5fca7a44bba3e
NEOTERM_PKG_DEPENDS="wget"
NEOTERM_PKG_SUGGESTS="xclip"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
neoterm_step_make_install() {
	install -Dm 755 -t "$NEOTERM_PREFIX/bin" wgetpaste
	install -Dm644 _wgetpaste $NEOTERM_PREFIX/share/zsh/site-functions/_wgetpaste
}
