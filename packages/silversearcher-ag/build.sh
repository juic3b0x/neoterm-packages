NEOTERM_PKG_HOMEPAGE=https://geoff.greer.fm/ag/
NEOTERM_PKG_DESCRIPTION="Fast grep-like program, alternative to ack-grep"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.0
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://geoff.greer.fm/ag/releases/the_silver_searcher-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d9621a878542f3733b5c6e71c849b9d1a830ed77cb1a1f6c2ea441d4b0643170
NEOTERM_PKG_DEPENDS="pcre, liblzma, zlib"

neoterm_step_pre_configure() {
	export CFLAGS+=" -fcommon"
}
