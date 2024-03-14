NEOTERM_PKG_HOMEPAGE=https://irssi.org/
NEOTERM_PKG_DESCRIPTION="Terminal based IRC client"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.5"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/irssi/irssi/releases/download/$NEOTERM_PKG_VERSION/irssi-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=72a951cb0ad622785a8962801f005a3a412736c7e7e3ce152f176287c52fe062
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, libandroid-glob, libiconv, libotr, ncurses, openssl, perl, utf8proc"
NEOTERM_PKG_BREAKS="irssi-dev"
NEOTERM_PKG_REPLACES="irssi-dev"
NEOTERM_MESON_PERL_CROSS_FILE=$NEOTERM_PKG_TMPDIR/meson-perl-cross-$NEOTERM_ARCH.txt
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dfhs-prefix=$NEOTERM_PREFIX
--cross-file $NEOTERM_MESON_PERL_CROSS_FILE
"

neoterm_step_configure() {
	neoterm_step_configure_meson
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"

	# Make build log less noisy.
	CFLAGS+=" -Wno-compound-token-split-by-macro"

	local perl_version=$(. $NEOTERM_SCRIPTDIR/packages/perl/build.sh; echo $NEOTERM_PKG_VERSION)

	cat <<- MESON_PERL_CROSS >$NEOTERM_MESON_PERL_CROSS_FILE
	[properties]
	perl_version = '$perl_version'
	perl_ccopts = ['-I$NEOTERM_PREFIX/include', '-D_LARGEFILE_SOURCE', '-D_FILE_OFFSET_BITS=64', '-I$NEOTERM_PREFIX/lib/perl5/$perl_version/${NEOTERM_ARCH}-android/CORE']
	perl_ldopts = ['-Wl,-E', '-I$NEOTERM_PREFIX/include', '-L$NEOTERM_PREFIX/lib/perl5/$perl_version/${NEOTERM_ARCH}-android/CORE', '-lperl', '-lm', '-ldl']
	perl_archname = '${NEOTERM_ARCH}-android'
	perl_installsitearch = '$NEOTERM_PREFIX/lib/perl5/site_perl/$perl_version/${NEOTERM_ARCH}-android'
	perl_installvendorarch = ''
	perl_inc = ['$NEOTERM_PREFIX/lib/perl5/site_perl/$perl_version/${NEOTERM_ARCH}-android', '$NEOTERM_PREFIX/lib/perl5/site_perl/$perl_version', '$NEOTERM_PREFIX/lib/perl5/$perl_version/${NEOTERM_ARCH}-android', '$NEOTERM_PREFIX/lib/perl5/$perl_version']
	MESON_PERL_CROSS
}
