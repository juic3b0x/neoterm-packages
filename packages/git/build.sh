NEOTERM_PKG_HOMEPAGE=https://git-scm.com/
NEOTERM_PKG_DESCRIPTION="Fast, scalable, distributed revision control system"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.44.0"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/pub/software/scm/git/git-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=e358738dcb5b5ea340ce900a0015c03ae86e804e7ff64e47aa4631ddee681de3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcurl, libexpat, libiconv, less, openssl, pcre2, zlib"
NEOTERM_PKG_RECOMMENDS="openssh"
NEOTERM_PKG_SUGGESTS="perl"

## This requires a working $NEOTERM_PREFIX/bin/sh on the host building:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_fread_reads_directories=yes
ac_cv_header_libintl_h=no
ac_cv_iconv_omits_bom=no
ac_cv_snprintf_returns_bogus=no
--with-curl
--with-expat
--with-shell=$NEOTERM_PREFIX/bin/sh
--with-tcltk=$NEOTERM_PREFIX/bin/wish
"
# expat is only used by git-http-push for remote lock management over DAV, so disable:
# NO_INSTALL_HARDLINKS to use symlinks instead of hardlinks (which does not work on Android M):
NEOTERM_PKG_EXTRA_MAKE_ARGS="
NO_NSEC=1
NO_GETTEXT=1
NO_INSTALL_HARDLINKS=1
PERL_PATH=$NEOTERM_PREFIX/bin/perl
USE_LIBPCRE2=1
"
NEOTERM_PKG_BUILD_IN_SRC=true

# Things to remove to save space:
#  bin/git-cvsserver - server emulating CVS
#  bin/git-shell - restricted login shell for Git-only SSH access
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/git-cvsserver
bin/git-shell
libexec/git-core/git-shell
libexec/git-core/git-cvsserver
share/man/man1/git-cvsserver.1
share/man/man1/git-shell.1
"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# Setup perl so that the build process can execute it:
	rm -f $NEOTERM_PREFIX/bin/perl
	ln -s $(command -v perl) $NEOTERM_PREFIX/bin/perl

	# Force fresh perl files (otherwise files from earlier builds
	# remains without bumped modification times, so are not picked
	# up by the package):
	rm -Rf $NEOTERM_PREFIX/share/git-perl

	# Fixes build if utfcpp is installed:
	CPPFLAGS="-I$NEOTERM_PKG_SRCDIR $CPPFLAGS"
}

neoterm_step_post_make_install() {
	# Installing man requires asciidoc and xmlto, so git uses separate make targets for man pages
	make -j $NEOTERM_MAKE_PROCESSES install-man

	make -j $NEOTERM_MAKE_PROCESSES -C contrib/subtree $NEOTERM_PKG_EXTRA_MAKE_ARGS
	make -C contrib/subtree $NEOTERM_PKG_EXTRA_MAKE_ARGS ${NEOTERM_PKG_MAKE_INSTALL_TARGET}
	make -j $NEOTERM_MAKE_PROCESSES -C contrib/subtree install-man

	mkdir -p $NEOTERM_PREFIX/etc/bash_completion.d/
	cp $NEOTERM_PKG_SRCDIR/contrib/completion/git-completion.bash \
	   $NEOTERM_PKG_SRCDIR/contrib/completion/git-prompt.sh \
	   $NEOTERM_PREFIX/etc/bash_completion.d/

	# Remove the build machine perl setup in neoterm_step_pre_configure to avoid it being packaged:
	rm $NEOTERM_PREFIX/bin/perl

	# Remove clutter:
	rm -Rf $NEOTERM_PREFIX/lib/*-linux*/perl

	# Remove duplicated binaries in bin/ with symlink to the one in libexec/git-core:
	(cd $NEOTERM_PREFIX/bin; ln -s -f ../libexec/git-core/git git)
	(cd $NEOTERM_PREFIX/bin; ln -s -f ../libexec/git-core/git-upload-pack git-upload-pack)
	(cd $NEOTERM_PREFIX/libexec/git-core; ln -s -f git-gui git-citool)
}

neoterm_step_post_massage() {
	if [ ! -f libexec/git-core/git-remote-https ]; then
		neoterm_error_exit "Git built without https support"
	fi
}
