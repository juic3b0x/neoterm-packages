## Note: APG project seems dead. Official homepage & src urls
## disappeared.

NEOTERM_PKG_HOMEPAGE=http://www.adel.nursat.kz/apg/index.shtml
NEOTERM_PKG_DESCRIPTION="Automated Password Generator"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.0b
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/neoterm/distfiles/releases/download/2021.01.04/apg-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d1e52029709e2d7f9cb99bedce3e02ee7a63cff7b8e2b4c2bc55b3dc03c28b92
NEOTERM_PKG_DEPENDS="libcrypt"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_extract_package() {
	# Fix permissions.
	find "$NEOTERM_PKG_SRCDIR" -type d -exec chmod 700 "{}" \;
	find "$NEOTERM_PKG_SRCDIR" -type f -executable -exec chmod 700 "{}" \;
	find "$NEOTERM_PKG_SRCDIR" -type f ! -executable -exec chmod 600 "{}" \;
}
