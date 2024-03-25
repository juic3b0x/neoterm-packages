NEOTERM_PKG_HOMEPAGE=https://pagure.io/mailcap
NEOTERM_PKG_DESCRIPTION="List of standard media types and their usual file extension"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="10.1.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://salsa.debian.org/debian/media-types/-/archive/${NEOTERM_PKG_VERSION}/media-types-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d24e54447bf7cdf6dcea4d55faeb74c8156b7aed0757b962f94a5b1f1ab0de5c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BREAKS="mime-support"
NEOTERM_PKG_REPLACES="mime-support"
NEOTERM_PKG_PROVIDES="mime-support"
NEOTERM_PKG_CONFFILES="etc/mime.types"
# etc/mime.types was previously in mutt:
NEOTERM_PKG_CONFLICTS="mutt (<< 1.8.3-1)"

neoterm_step_make_install() {
	install -Dm600 $NEOTERM_PKG_SRCDIR/mime.types $NEOTERM_PREFIX/etc/mime.types
}
