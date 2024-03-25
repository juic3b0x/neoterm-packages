NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/emacs/
NEOTERM_PKG_DESCRIPTION="Extensible, customizable text editor-and more"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Update both emacs and emacs-x to the same version in one PR.
_VERSION=29.2
NEOTERM_PKG_VERSION=${_VERSION}
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/emacs/emacs-${_VERSION}.tar.xz
if [[ $NEOTERM_PKG_VERSION == *-rc* ]]; then
	NEOTERM_PKG_SRCURL=https://alpha.gnu.org/gnu/emacs/pretest/emacs-${NEOTERM_PKG_VERSION#*:}.tar.xz
fi
NEOTERM_PKG_SHA256=7d3d2448988720bf4bf57ad77a5a08bf22df26160f90507a841ba986be2670dc
NEOTERM_PKG_DEPENDS="libgmp, libgnutls, libjansson, libsqlite, libxml2, ncurses, zlib, libtreesitter"
NEOTERM_PKG_BREAKS="emacs-dev"
NEOTERM_PKG_REPLACES="emacs-dev"
NEOTERM_PKG_SERVICE_SCRIPT=("emacsd" 'exec emacs --fg-daemon 2>&1')
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-autodepend
--with-dumping=none
--with-gif=no
--with-gnutls
--with-jpeg=no
--with-json
--with-modules
--with-pdumper=yes
--with-png=no
--with-tiff=no
--with-xml2
--with-xpm=no
--with-tree-sitter
--without-dbus
--without-gconf
--without-gsettings
--without-lcms2
--without-selinux
--without-x
"

if $NEOTERM_DEBUG_BUILD; then
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
	--enable-checking=yes,glyphs
	--enable-check-lisp-object-type
	"
	CFLAGS+=" -gdwarf-4"
fi

# Avoid misdetection of sigaltstack with strict C99:
# https://github.com/juic3b0x/neoterm-packages/issues/15852
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_alternate_stack=yes"
# Ensure use of system malloc:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_sanitize_address=yes"
# Prevent configure from adding -nopie:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_prog_cc_no_pie=no"
# Prevent linking against libelf:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_elf_elf_begin=no"
# implemented using dup3(), which fails if oldfd == newfd
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" gl_cv_func_dup2_works=no"
# disable setrlimit function to make neoterm-am work from within emacs
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_setrlimit=no"
if [ "$NEOTERM_ARCH" == "arm" ] || [ "$NEOTERM_ARCH" == "i686" ]; then
	# setjmp does not work properly on 32bit android:
	# https://github.com/juic3b0x/neoterm-packages/issues/2599
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_func__setjmp=no"
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_func_sigsetjmp=no"
fi
NEOTERM_PKG_HOSTBUILD=true

# Remove some irrelevant files:
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/grep-changelog
share/applications/emacs.desktop
share/emacs/${_VERSION}/etc/emacs.desktop
share/emacs/${_VERSION}/etc/emacs.icon
share/emacs/${_VERSION}/etc/images
share/emacs/${_VERSION}/etc/refcards
share/emacs/${_VERSION}/etc/tutorials/TUTORIAL.*
share/icons
share/man/man1/grep-changelog.1.gz
"

# Remove ctags from the emacs package to prevent conflicting with
# the Universal Ctags from the 'ctags' package (the bin/etags
# program still remain in the emacs package):
NEOTERM_PKG_RM_AFTER_INSTALL+=" bin/ctags share/man/man1/ctags.1 share/man/man1/ctags.1.gz"


neoterm_step_post_get_source() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# Version guard
	local ver_e=${NEOTERM_PKG_VERSION#*:}
	local ver_x=$(. $NEOTERM_SCRIPTDIR/x11-packages/emacs-x/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	if [ "${ver_e}" != "${ver_x}" ]; then
		neoterm_error_exit "Version mismatch between emacs and emacs-x."
	fi

	# XXX: We have to start with new host build each time
	#      to avoid build error when cross compiling.
	rm -Rf $NEOTERM_PKG_HOSTBUILD_DIR

	# NeoTerm only use info pages for emacs. Remove the info directory
	# to get a clean Info directory file dir.
	rm -Rf $NEOTERM_PREFIX/share/info
}

neoterm_step_host_build() {
	local _VERSION=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d - -f 1)
	# Build a bootstrap-emacs binary to be used in neoterm_step_post_configure.
	local NATIVE_PREFIX=$NEOTERM_PKG_TMPDIR/emacs-native
	mkdir -p $NATIVE_PREFIX/share/emacs/${_VERSION}
	ln -s $NEOTERM_PKG_SRCDIR/lisp $NATIVE_PREFIX/share/emacs/${_VERSION}/lisp
	( cd $NEOTERM_PKG_SRCDIR; ./autogen.sh )
	$NEOTERM_PKG_SRCDIR/configure --prefix=$NATIVE_PREFIX --without-all --without-x
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_post_configure() {
	cp $NEOTERM_PKG_HOSTBUILD_DIR/src/bootstrap-emacs $NEOTERM_PKG_BUILDDIR/src/bootstrap-emacs
	cp $NEOTERM_PKG_HOSTBUILD_DIR/lib-src/make-docfile $NEOTERM_PKG_BUILDDIR/lib-src/make-docfile
	cp $NEOTERM_PKG_HOSTBUILD_DIR/lib-src/make-fingerprint $NEOTERM_PKG_BUILDDIR/lib-src/make-fingerprint
	cp -r $NEOTERM_PKG_SRCDIR/lisp/* $NEOTERM_PKG_BUILDDIR/lisp
	cp -r $NEOTERM_PKG_SRCDIR/etc $NEOTERM_PKG_BUILDDIR
	# Update timestamps so that the binaries does not get rebuilt:
	touch -d "next hour" $NEOTERM_PKG_BUILDDIR/src/bootstrap-emacs \
		$NEOTERM_PKG_BUILDDIR/lib-src/make-docfile \
		$NEOTERM_PKG_BUILDDIR/lib-src/make-fingerprint
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/emacs/${_VERSION}/lisp/emacs-lisp/
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/site-start.el \
		$NEOTERM_PREFIX/share/emacs/site-lisp/site-start.el
}

neoterm_step_create_debscripts() {
	local _VERSION=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d - -f 1)
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/emacs 40
		fi
	fi

	cd $NEOTERM_PREFIX/share/emacs/${_VERSION}/lisp
	LC_ALL=C $NEOTERM_PREFIX/bin/emacs -batch -l loadup --temacs=pdump
	mv $NEOTERM_PREFIX/bin/emacs*.pdmp $NEOTERM_PREFIX/libexec/emacs/${_VERSION}/${NEOTERM_ARCH}-linux-android*/
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/emacs
		fi
	fi
	EOF
}
