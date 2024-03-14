NEOTERM_PKG_HOMEPAGE=https://github.com/jmacd/xdelta
NEOTERM_PKG_DESCRIPTION='xdelta3 - VCDIFF (RFC 3284) binary diff tool'
NEOTERM_PKG_LICENSE=Apache-2.0
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/jmacd/xdelta/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7515cf5378fca287a57f4e2fee1094aabc79569cfe60d91e06021a8fd7bae29d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS=liblzma

neoterm_step_post_get_source() {
	NEOTERM_PKG_SRCDIR+=/xdelta3
}

neoterm_step_pre_configure() {
	autoreconf --install

	CPPFLAGS+=" -DXD3_USE_LARGEFILE64 -D_FILE_OFFSET_BITS=64"
}
