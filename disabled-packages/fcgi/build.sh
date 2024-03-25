NEOTERM_PKG_HOMEPAGE=http://www.fastcgi.com/
NEOTERM_PKG_DESCRIPTION="A language independent, high performant extension to CGI"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE.TERMS"
NEOTERM_PKG_VERSION=2.4.2
NEOTERM_PKG_SRCURL=https://github.com/FastCGI-Archives/fcgi2/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1fe83501edfc3a7ec96bb1e69db3fd5ea1730135bd73ab152186fd0b437013bc
NEOTERM_PKG_BREAKS="fcgi-dev"
NEOTERM_PKG_REPLACES="fcgi-dev"

neoterm_step_pre_configure() {
	libtoolize --automake --copy --force
	aclocal
	autoheader
	automake --add-missing --force-missing --copy
	autoconf
	export LIBS="-lm"
}
