NEOTERM_PKG_HOMEPAGE=http://e-x-a.org/codecrypt/
NEOTERM_PKG_DESCRIPTION="The post-quantum cryptography tool"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8
NEOTERM_PKG_REVISION=9
NEOTERM_PKG_SRCURL=https://github.com/exaexa/codecrypt/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=25f11bc361b4f8aca7245698334b5715b7d594d708a75e8cdb2aa732dc46eb96
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="cryptopp, fftw, libc++, libgmp"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-cryptopp"

neoterm_step_pre_configure() {
	./autogen.sh
	export LIBS="-lm"
	export CRYPTOPP_CFLAGS="-I$NEOTERM_PREFIX/include"
	export CRYPTOPP_LIBS="-L$NEOTERM_PREFIX/lib -lcryptopp"
}
