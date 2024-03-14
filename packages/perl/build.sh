NEOTERM_PKG_HOMEPAGE=https://www.perl.org/
NEOTERM_PKG_DESCRIPTION="Capable, feature-rich programming language"
NEOTERM_PKG_LICENSE="Artistic-License-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Packages which should be rebuilt after version change:
# - exiftool
# - irssi
# - libapt-pkg-perl
# - libregexp-assemble-perl
# - psutils
# - subversion
NEOTERM_PKG_VERSION=(5.38.2
                    388d0eedbfc3864bbbf7ad7f965064d99cac5aaa)
NEOTERM_PKG_SHA256=(a0a31534451eb7b83c7d6594a497543a54d488bc90ca00f5e34762577f40655e
                   a975c196075623f0dc94f57d00633b0d18ed08e3d85a3ea19d34ece4ec1a94c1)
NEOTERM_PKG_SRCURL=(http://www.cpan.org/src/5.0/perl-${NEOTERM_PKG_VERSION}.tar.gz
		   https://github.com/arsv/perl-cross/archive/${NEOTERM_PKG_VERSION[1]}.tar.gz)
#		   https://github.com/arsv/perl-cross/releases/download/${NEOTERM_PKG_VERSION[1]}/perl-cross-${NEOTERM_PKG_VERSION[1]}.tar.gz)
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_MAKE_PROCESSES=1
NEOTERM_PKG_RM_AFTER_INSTALL="bin/perl${NEOTERM_PKG_VERSION}"

neoterm_step_post_get_source() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# This port uses perl-cross: http://arsv.github.io/perl-cross/
	cp -rf perl-cross-${NEOTERM_PKG_VERSION[1]}/* .

	# Remove old installation to force fresh:
	rm -rf $NEOTERM_PREFIX/lib/perl5
	rm -f $NEOTERM_PREFIX/lib/libperl.so
	rm -f $NEOTERM_PREFIX/include/perl
}

neoterm_step_configure() {
	export PATH=$PATH:$NEOTERM_STANDALONE_TOOLCHAIN/bin

	(
		ORIG_AR=$AR; unset AR
		ORIG_AS=$AS; unset AS
		ORIG_CC=$CC; unset CC
		ORIG_CXX=$CXX; unset CXX
		ORIG_CFLAGS=$CFLAGS; unset CFLAGS
		ORIG_CPPFLAGS=$CPPFLAGS; unset CPPFLAGS
		ORIG_CXXFLAGS=$CXXFLAGS; unset CXXFLAGS
		ORIG_LDFLAGS=$LDFLAGS; unset LDFLAGS
		ORIG_RANLIB=$RANLIB; unset RANLIB
		ORIG_LD=$LD; unset LD

		cd $NEOTERM_PKG_BUILDDIR
		$NEOTERM_PKG_SRCDIR/configure \
			--target=$NEOTERM_HOST_PLATFORM \
			--with-cc="$ORIG_CC" \
			--with-ranlib="$ORIG_RANLIB" \
			-Dosname=android \
			-Dsysroot=$NEOTERM_STANDALONE_TOOLCHAIN/sysroot \
			-Dprefix=$NEOTERM_PREFIX \
			-Dsh=$NEOTERM_PREFIX/bin/sh \
			-Dld="$ORIG_CC -Wl,-rpath=$NEOTERM_PREFIX/lib -Wl,--enable-new-dtags" \
			-Dar="$ORIG_AR" \
			-Duseshrplib \
			-Duseithreads \
			-Dusemultiplicity \
			-Doptimize="-O2"
	)
}

neoterm_step_post_make_install() {
	# Replace hardlinks with symlinks:
	cd $NEOTERM_PREFIX/share/man/man1
	rm perlbug.1
	ln -s perlthanks.1 perlbug.1
	cd $NEOTERM_PREFIX/bin
	rm perlbug
	ln -s perlthanks perlbug

	cd $NEOTERM_PREFIX/lib
	ln -f -s perl5/${NEOTERM_PKG_VERSION}/${NEOTERM_ARCH}-android/CORE/libperl.so libperl.so

	cd $NEOTERM_PREFIX/include
	ln -f -s ../lib/perl5/${NEOTERM_PKG_VERSION}/${NEOTERM_ARCH}-android/CORE perl
	cd ../lib/perl5/${NEOTERM_PKG_VERSION}/${NEOTERM_ARCH}-android/
	chmod +w Config_heavy.pl
	sed 's',"--sysroot=$NEOTERM_STANDALONE_TOOLCHAIN"/sysroot,"-I${NEOTERM_PREFIX}/include",'g' Config_heavy.pl > Config_heavy.pl.new
	sed 's',"$NEOTERM_STANDALONE_TOOLCHAIN"/sysroot,"-I${NEOTERM_PREFIX%%/usr}",'g' Config_heavy.pl.new > Config_heavy.pl
	rm Config_heavy.pl.new
}
