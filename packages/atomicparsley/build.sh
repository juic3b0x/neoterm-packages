NEOTERM_PKG_HOMEPAGE=https://github.com/wez/atomicparsley
NEOTERM_PKG_DESCRIPTION="Read, parse and set metadata of MPEG-4 and 3gp files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:20221229.172126.d813aa6"
NEOTERM_PKG_SRCURL=https://github.com/wez/atomicparsley/archive/${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=2f095a251167dc771e8f4434abe4a9c7af7d8e13c718fb8439a0e0d97078899b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libc++, zlib"

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin AtomicParsley
}
