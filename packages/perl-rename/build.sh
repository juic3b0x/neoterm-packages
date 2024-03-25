NEOTERM_PKG_HOMEPAGE=https://search.cpan.org/~pederst/rename/
NEOTERM_PKG_DESCRIPTION="renames multiple files using perl expressions."
NEOTERM_PKG_LICENSE="Artistic-License-2.0, GPL-2.0" # https://metacpan.org/pod/Software::License::Perl_5
NEOTERM_PKG_MAINTAINER="@ELWAER-M"
NEOTERM_PKG_VERSION=1.14
NEOTERM_PKG_SRCURL=https://cpan.metacpan.org/authors/id/P/PE/PEDERST/rename-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4d19e5cb8fb09fe35e6df69ae07132cf621b0b2a82f54149091bce630642adbd
NEOTERM_PKG_DEPENDS="perl"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
PREFIX=$NEOTERM_PREFIX
INSTALLSITEMAN1DIR=$NEOTERM_PREFIX/share/man/man1
INSTALLSITEMAN3DIR=$NEOTERM_PREFIX/share/man/man3
"

neoterm_step_configure() {
	perl Makefile.PL $NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
}

neoterm_step_post_massage() {
	find $NEOTERM_PKG_MASSAGEDIR -type f -name "rename*" -execdir sh -c 'mv {} $(echo {} | sed "s|rename|perl-rename|")' \;
	rm -rf $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib/x86_64-linux-gnu
}
