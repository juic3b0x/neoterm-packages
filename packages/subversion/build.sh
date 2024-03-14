NEOTERM_PKG_HOMEPAGE=https://subversion.apache.org
NEOTERM_PKG_DESCRIPTION="Centralized version control system characterized by its simplicity"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.14.3
NEOTERM_PKG_SRCURL=https://www.apache.org/dist/subversion/subversion-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=949efd451a09435f7e8573574c71c7b71b194d844890fa49cd61d2262ea1a440
NEOTERM_PKG_DEPENDS="apr, apr-util, serf, libexpat, libsqlite, liblz4, utf8proc, zlib"
NEOTERM_PKG_BREAKS="subversion-dev"
NEOTERM_PKG_REPLACES="subversion-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
svn_cv_pycfmt_apr_int64_t=UNUSED_REMOVE_AFTER_NEXT_UPDATE
--without-sasl
--without-libmagic
"

neoterm_step_pre_configure() {
	CFLAGS+=" -std=c11 -I$NEOTERM_PREFIX/include/perl"
	LDFLAGS+=" -lm -Wl,--as-needed -L$NEOTERM_PREFIX/include/perl"
}

neoterm_step_post_make_install() {
	make -j $NEOTERM_MAKE_PROCESSES install-swig-pl-lib

	pushd subversion/bindings/swig/perl/native
	# it's probably not needed to pass all flags to both perl and make
	# but it works
	PERL_MM_USE_DEFAULT=1 INSTALLDIRS=site CC="$CC" LD="$CC" \
		OPTIMIZE="$CFLAGS" CFLAGS="$CFLAGS" CCFLAGS="$CFLAGS" \
		LDFLAGS="$LDFLAGS -lperl" LDDLFLAGS="-shared $CFLAGS $LDFLAGS -lperl" \
		INSTALLSITEMAN3DIR="$NEOTERM_PREFIX/share/man/man3" \
		perl Makefile.PL PREFIX="$NEOTERM_PREFIX"
	popd

	make -j $NEOTERM_MAKE_PROCESSES PREFIX="$NEOTERM_PREFIX" \
		PERL_MM_USE_DEFAULT=1 INSTALLDIRS=site CC="$CC" LD="$CC" \
		OPTIMIZE="$CFLAGS" CFLAGS="$CFLAGS" CCFLAGS="$CFLAGS" \
		LDFLAGS="$LDFLAGS -lperl" LDDLFLAGS="-shared $CFLAGS $LDFLAGS -lperl" \
		INSTALLSITEMAN3DIR="$NEOTERM_PREFIX/share/man/man3" \
		install-swig-pl

	local perl_version=$(. $NEOTERM_SCRIPTDIR/packages/perl/build.sh; echo $NEOTERM_PKG_VERSION)
	local host_perl_version=$(perl -e 'printf "%vd\n", $^V;')
	cd "$NEOTERM_PREFIX/lib"
	rm "x86_64-linux-gnu/perl/$host_perl_version/perllocal.pod"
	mkdir -p "perl5/site_perl/$perl_version/${NEOTERM_ARCH}-android"
	mv "x86_64-linux-gnu/perl/$host_perl_version/"* \
		"perl5/site_perl/$perl_version/${NEOTERM_ARCH}-android"
	rmdir x86_64-linux-gnu/{perl/{"$host_perl_version/",},}
}
