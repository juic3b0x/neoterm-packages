NEOTERM_PKG_HOMEPAGE=https://github.com/jbboehr/php-psr
NEOTERM_PKG_DESCRIPTION="PHP extension providing the accepted PSR interfaces"
NEOTERM_PKG_LICENSE="BSD Simplified"
NEOTERM_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
NEOTERM_PKG_VERSION=1.2.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/jbboehr/php-psr/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fa4071bedf625b3f434b4dbcc005913d291790039d03ae429bfea252f9ab2b54
NEOTERM_PKG_DEPENDS=php
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	$NEOTERM_PREFIX/bin/phpize
}
