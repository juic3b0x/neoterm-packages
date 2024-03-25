NEOTERM_PKG_HOMEPAGE=https://metacpan.org/pod/Regexp::Assemble
NEOTERM_PKG_DESCRIPTION="Perl module to merge several regular expressions"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.38
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=https://salsa.debian.org/perl-team/modules/packages/libregexp-assemble-perl/-/archive/upstream/${NEOTERM_PKG_VERSION}/libregexp-assemble-perl-upstream-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=ca31b4111b825a4aa5262b07412822457910577881c2edb19407baad3997ebb0
NEOTERM_PKG_DEPENDS="perl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true


neoterm_step_configure() {
	perl Makefile.PL
}

neoterm_step_make_install() {
	local perl_version=$(. $NEOTERM_SCRIPTDIR/packages/perl/build.sh; echo $NEOTERM_PKG_VERSION)
	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/share/man/man3/
	cp $NEOTERM_PKG_SRCDIR/blib/man3/Regexp::Assemble.3pm \
		$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/share/man/man3/

	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib/perl5/site_perl/$perl_version/Regexp/
	cp $NEOTERM_PKG_SRCDIR/lib/Regexp/Assemble.pm \
		$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib/perl5/site_perl/$perl_version/Regexp/
}
