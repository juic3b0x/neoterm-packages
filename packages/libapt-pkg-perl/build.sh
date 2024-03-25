NEOTERM_PKG_HOMEPAGE=https://packages.debian.org/libapt-pkg-perl
NEOTERM_PKG_DESCRIPTION="Perl interface to APT's libapt-pkg"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1.40
NEOTERM_PKG_REVISION=10
NEOTERM_PKG_SRCURL=http://deb.debian.org/debian/pool/main/liba/libapt-pkg-perl/libapt-pkg-perl_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=524d2ef77f3d6896c50e7674022d85e4a391a6a2b3c65ba5e50ac671fa7ce4a1
NEOTERM_PKG_DEPENDS="apt, libc++, perl"
NEOTERM_PKG_BUILD_IN_SRC=true


neoterm_step_make() {
	local perl_version=$(. $NEOTERM_SCRIPTDIR/packages/perl/build.sh; echo $NEOTERM_PKG_VERSION)
	CFLAGS+=" -I$NEOTERM_PREFIX/lib/perl5/$perl_version/${NEOTERM_ARCH}-android/CORE \
		-I$NEOTERM_PREFIX/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
	LDFLAGS+=" -L$NEOTERM_PREFIX/lib/perl5/$perl_version/${NEOTERM_ARCH}-android/CORE \
		-L$NEOTERM_PREFIX/lib -lperl"
	perl Makefile.PL INSTALLDIRS=perl DESTDIR="$NEOTERM_PKG_MASSAGEDIR" \
		INSTALLMAN3DIR="$NEOTERM_PREFIX/share/man/man3" \
		LIB=$NEOTERM_PREFIX/lib/perl5/site_perl/$perl_version/${NEOTERM_ARCH}-android
	make CC="${CC}++" LD="${CC}++" OTHERLDFLAGS="$LDFLAGS" CCFLAGS="$CFLAGS"
}

neoterm_step_post_massage() {
	local perl_version=$(. $NEOTERM_SCRIPTDIR/packages/perl/build.sh; echo $NEOTERM_PKG_VERSION)
	mv $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib/perl5/site_perl/$perl_version/${NEOTERM_ARCH}-android/x86_64-linux-gnu-thread-multi/* \
		$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib/perl5/site_perl/$perl_version/${NEOTERM_ARCH}-android/
	rmdir $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib/perl5/site_perl/$perl_version/${NEOTERM_ARCH}-android/x86_64-linux-gnu-thread-multi
}
