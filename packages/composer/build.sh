NEOTERM_PKG_HOMEPAGE=https://getcomposer.org/
NEOTERM_PKG_DESCRIPTION="Dependency Manager for PHP"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@PuneetGopinath"
NEOTERM_PKG_VERSION="2.7.2"
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_SRCURL=git+https://github.com/composer/composer
NEOTERM_PKG_DEPENDS="php"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make_install() {
	composer install
	php -d phar.readonly=Off bin/compile
	install -Dm700 composer.phar $NEOTERM_PREFIX/bin/composer
}
