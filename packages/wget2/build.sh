NEOTERM_PKG_HOMEPAGE=https://gitlab.com/gnuwget/wget2
NEOTERM_PKG_DESCRIPTION="The successor of GNU Wget, a file and recursive website downloader"
NEOTERM_PKG_LICENSE="GPL-3.0, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.0
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/wget/wget2-${NEOTERM_PKG_VERSION}.tar.lz
NEOTERM_PKG_SHA256=bc034194b512bb83ce0171d15a8db33e1c5c3ab8b3e343e1e6f2cf48f9154fad
NEOTERM_PKG_DEPENDS="brotli, gpgme, libandroid-glob, libgnutls, libiconv, libidn2, libnghttp2, pcre2, zlib, zstd"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_spawn_h=no
-with-openssl=no
--with-ssl=gnutls
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CFLAGS+=" -DNO_INLINE_GETPASS=1"
}
