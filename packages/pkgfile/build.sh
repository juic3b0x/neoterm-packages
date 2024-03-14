NEOTERM_PKG_HOMEPAGE=https://github.com/falconindy/pkgfile
NEOTERM_PKG_DESCRIPTION="An alpm .files metadata explorer"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=21
NEOTERM_PKG_SRCURL=https://github.com/falconindy/pkgfile/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=809d75738cae785839950c85371ac087bc3b450eed497a565eca01b653f254a5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libandroid-glob, libarchive, libcurl, pcre"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dsystemd_units=false
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/cache/pkgfile
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" != "pacman" ] && [ "\$1" != "remove" ]; then
	exit 0
	fi
	rm -rf $NEOTERM_PREFIX/var/cache/pkgfile
	EOF
}
