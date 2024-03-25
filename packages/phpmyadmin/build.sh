NEOTERM_PKG_HOMEPAGE=https://www.phpmyadmin.net
NEOTERM_PKG_DESCRIPTION="A PHP tool for administering MySQL databases"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.2.1
NEOTERM_PKG_SRCURL=https://files.phpmyadmin.net/phpMyAdmin/$NEOTERM_PKG_VERSION/phpMyAdmin-$NEOTERM_PKG_VERSION-all-languages.tar.xz
NEOTERM_PKG_SHA256=373f9599dfbd96d6fe75316d5dad189e68c305f297edf42377db9dd6b41b2557
NEOTERM_PKG_DEPENDS="apache2, php"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_CONFFILES="etc/phpmyadmin/config.inc.php"

neoterm_step_make_install() {
	rm -rf $NEOTERM_PREFIX/share/phpmyadmin
	mkdir -p $NEOTERM_PREFIX/share/phpmyadmin
	cp -a $NEOTERM_PKG_SRCDIR/* $NEOTERM_PREFIX/share/phpmyadmin/
	mkdir -p $NEOTERM_PREFIX/etc/phpmyadmin
	cp $NEOTERM_PKG_SRCDIR/config.sample.inc.php $NEOTERM_PREFIX/etc/phpmyadmin/config.inc.php
	ln -s $NEOTERM_PREFIX/etc/phpmyadmin/config.inc.php $NEOTERM_PREFIX/share/phpmyadmin
	mkdir -p $NEOTERM_PREFIX/etc/apache2/conf.d
	sed -e "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" $NEOTERM_PKG_BUILDER_DIR/phpmyadmin.conf \
		> $NEOTERM_PREFIX/etc/apache2/conf.d/phpmyadmin.conf
}
