NEOTERM_PKG_HOMEPAGE=https://github.com/dmpop/tenki
NEOTERM_PKG_DESCRIPTION="A simple PHP application for logging current weather conditions, notes, and waypoints"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=cb07deb9d8c8fc5849f8752f6f0605f72f96fd9b
NEOTERM_PKG_VERSION=2022.05.26
NEOTERM_PKG_SRCURL=git+https://github.com/dmpop/tenki
NEOTERM_PKG_SHA256=7bdea2d3e09709d6562503833c4cd995aa40303a14c75f6a4338dfd40750d2ca
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_DEPENDS="apache2, php"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_make_install() {
	local _TENKI_ROOT=$NEOTERM_PREFIX/share/tenki-php
	rm -rf ${_TENKI_ROOT}
	mkdir -p ${_TENKI_ROOT}
	cp -a $NEOTERM_PKG_SRCDIR/* ${_TENKI_ROOT}/
	local _APACHE_CONF_DIR=$NEOTERM_PREFIX/etc/apache2/conf.d
	mkdir -p ${_APACHE_CONF_DIR}
	sed -e "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
		$NEOTERM_PKG_BUILDER_DIR/tenki-php.conf \
		> ${_APACHE_CONF_DIR}/tenki-php.conf
}
