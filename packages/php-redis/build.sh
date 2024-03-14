NEOTERM_PKG_HOMEPAGE=https://github.com/phpredis/phpredis
NEOTERM_PKG_DESCRIPTION="PHP extension for interfacing with Redis"
NEOTERM_PKG_LICENSE="PHP-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.0.2"
NEOTERM_PKG_SRCURL=https://github.com/phpredis/phpredis/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=786944f1c7818cc7fd4289a0d0a42ea630a07ebfa6dfa9f70ba17323799fc430
NEOTERM_PKG_DEPENDS=php
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	$NEOTERM_PREFIX/bin/phpize
}
