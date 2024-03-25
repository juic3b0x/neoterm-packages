NEOTERM_PKG_HOMEPAGE=https://www.zlib.net/pigz
NEOTERM_PKG_DESCRIPTION="Parallel implementation of the gzip file compressor"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.8
NEOTERM_PKG_SRCURL=https://www.zlib.net/pigz/pigz-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=eb872b4f0e1f0ebe59c9f7bd8c506c4204893ba6a8492de31df416f0d5170fd0
NEOTERM_PKG_DEPENDS="zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 pigz $NEOTERM_PREFIX/bin/pigz
	ln -sfr $NEOTERM_PREFIX/bin/pigz $NEOTERM_PREFIX/bin/unpigz
	install -Dm600 pigz.1 $NEOTERM_PREFIX/share/man/man1/pigz.1
}
