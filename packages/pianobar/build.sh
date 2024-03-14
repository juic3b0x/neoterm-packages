NEOTERM_PKG_HOMEPAGE=https://6xq.net/pianobar/
NEOTERM_PKG_DESCRIPTION="pianobar is a free/open-source, console-based client for the personalized online radio Pandora."
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2022.04.01
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/PromyLOPh/pianobar/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2653c6659a141868625ab24ecf04210d20347d50e0bd03e670e2daefa9f4fb2d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libao, ffmpeg, libgcrypt, libcurl, json-c"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_make_install(){
	#install useful script
	install -Dm755 "$NEOTERM_PKG_SRCDIR"/contrib/headless_pianobar "$NEOTERM_PREFIX"/bin/pianoctl
}
