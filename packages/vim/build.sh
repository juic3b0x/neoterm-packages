NEOTERM_PKG_HOMEPAGE=https://www.vim.org
NEOTERM_PKG_DESCRIPTION="Vi IMproved - enhanced vi editor"
NEOTERM_PKG_LICENSE="VIM License"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_DEPENDS="libiconv, ncurses, vim-runtime"
NEOTERM_PKG_RECOMMENDS="diffutils"
# vim should only be updated every 50 releases on multiples of 50.
# Update all of vim, vim-python and vim-gtk to the same version in one PR.
NEOTERM_PKG_VERSION=9.1.0100
NEOTERM_PKG_SRCURL="https://github.com/vim/vim/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=b2fe9e2849eded2bf15603c032bcd7a4f375a743be686330b7fa8e598c416766
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
vim_cv_getcwd_broken=no
vim_cv_memmove_handles_overlap=yes
vim_cv_stat_ignores_slash=no
vim_cv_terminfo=yes
vim_cv_tgetent=zero
vim_cv_toupper_broken=no
vim_cv_tty_group=world
--enable-gui=no
--enable-multibyte
--enable-netbeans=no
--with-features=huge
--without-x
--with-tlib=ncursesw
"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/rview
bin/rvim
bin/ex
share/man/man1/evim.1
share/icons
share/vim/vim91/spell/en.ascii*
share/vim/vim91/print
share/vim/vim91/tools
"
NEOTERM_PKG_CONFFILES="share/vim/vimrc"

NEOTERM_PKG_CONFLICTS="vim-python"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# Version guard
	local ver_v=$(. $NEOTERM_SCRIPTDIR/packages/vim/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	local ver_p=$(. $NEOTERM_SCRIPTDIR/packages/vim-python/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	local ver_g=$(. $NEOTERM_SCRIPTDIR/x11-packages/vim-gtk/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	if [ "${ver_v}" != "${ver_p}" ] || [ "${ver_p}" != "${ver_g}" ]; then
		neoterm_error_exit "Version mismatch between vim, vim-python and vim-gtk."
	fi

	make distclean

	# Remove eventually existing symlinks from previous builds so that they get re-created
	for b in rview rvim ex view vimdiff; do rm -f $NEOTERM_PREFIX/bin/$b; done
	rm -f $NEOTERM_PREFIX/share/man/man1/view.1
}

neoterm_step_post_make_install() {
	sed -e "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" $NEOTERM_PKG_BUILDER_DIR/vimrc \
		> $NEOTERM_PREFIX/share/vim/vimrc

	# Remove most tutor files:
	cp $NEOTERM_PREFIX/share/vim/vim91/tutor/{tutor,tutor.vim,tutor.utf-8} $NEOTERM_PKG_TMPDIR/
	rm -f $NEOTERM_PREFIX/share/vim/vim91/tutor/*
	cp $NEOTERM_PKG_TMPDIR/{tutor,tutor.vim,tutor.utf-8} $NEOTERM_PREFIX/share/vim/vim91/tutor/
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/editor editor $NEOTERM_PREFIX/bin/vim 50
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/vi vi $NEOTERM_PREFIX/bin/vim 20
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $NEOTERM_PREFIX/bin/vim
			update-alternatives --remove vi $NEOTERM_PREFIX/bin/vim
		fi
	fi
	EOF
}
