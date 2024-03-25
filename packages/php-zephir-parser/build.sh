NEOTERM_PKG_HOMEPAGE=https://github.com/phalcon/php-zephir-parser
NEOTERM_PKG_DESCRIPTION="The Zephir Parser delivered as a C extension for the PHP language"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
NEOTERM_PKG_VERSION="1.6.0"
NEOTERM_PKG_SRCURL=https://github.com/zephir-lang/php-zephir-parser/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d3bcebecc59601e53142231146cb91dbe3d0b40f7acb522b3a7786d209d2db90
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS=php
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_pre_configure() {
	# copy host build `lemon`
	cp "$NEOTERM_PKG_HOSTBUILD_DIR/lemon" $NEOTERM_PKG_SRCDIR/parser/
	$NEOTERM_PREFIX/bin/phpize
}

neoterm_step_host_build() {
	# lemon excuted by build host, so we need build it by hostbuild, then it will be reused by later build
	gcc -o "$NEOTERM_PKG_HOSTBUILD_DIR/lemon" $NEOTERM_PKG_SRCDIR/parser/lemon.c

}
