NEOTERM_PKG_HOMEPAGE=https://www.vim.org
NEOTERM_PKG_DESCRIPTION="Vi IMproved - enhanced vi editor"
NEOTERM_PKG_LICENSE="VIM License"
NEOTERM_PKG_MAINTAINER="@neoterm"

# vim should only be updated every 50 releases on multiples of 50.
# Update all of vim, vim-python and vim-gtk to the same version in one PR.
NEOTERM_PKG_VERSION=9.1.0100
NEOTERM_PKG_SRCURL="https://github.com/vim/vim/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=b2fe9e2849eded2bf15603c032bcd7a4f375a743be686330b7fa8e598c416766
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libcanberra, libice, libiconv, liblua52, libsm, libx11, libxt, ncurses, pango, python"
NEOTERM_PKG_CONFLICTS="vim, vim-python, vim-runtime"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_small_wchar_t=no
ac_cv_path_vi_cv_path_plain_lua=lua5.2
vi_cv_path_python3_pfx=$NEOTERM_PREFIX
vi_cv_path_python3_include=${NEOTERM_PREFIX}/include/python${NEOTERM_PYTHON_VERSION}
vi_cv_path_python3_platinclude=${NEOTERM_PREFIX}/include/python${NEOTERM_PYTHON_VERSION}
vi_cv_var_python3_abiflags=
vi_cv_var_python3_version=${NEOTERM_PYTHON_VERSION}
vim_cv_getcwd_broken=no
vim_cv_memmove_handles_overlap=yes
vim_cv_stat_ignores_slash=no
vim_cv_terminfo=yes
vim_cv_tgetent=zero
vim_cv_toupper_broken=no
vim_cv_tty_group=world
--enable-cscope
--enable-gui=gtk3
--enable-multibyte
--enable-luainterp
--enable-python3interp
--with-features=huge
--with-lua-prefix=$NEOTERM_PREFIX
--with-python3-config-dir=$NEOTERM_PYTHON_HOME/config-${NEOTERM_PYTHON_VERSION}/
--with-tlib=ncursesw
--with-x"

NEOTERM_PKG_RM_AFTER_INSTALL="
share/vim/vim91/spell/en.ascii*
share/vim/vim91/print
share/vim/vim91/tools
"

NEOTERM_PKG_CONFFILES="share/vim/vimrc"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem"

	# Version guard
	local ver_v=$(. $NEOTERM_SCRIPTDIR/packages/vim/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	local ver_p=$(. $NEOTERM_SCRIPTDIR/packages/vim-python/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	local ver_g=$(. $NEOTERM_SCRIPTDIR/x11-packages/vim-gtk/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	if [ "${ver_v}" != "${ver_p}" ] || [ "${ver_p}" != "${ver_g}" ]; then
		neoterm_error_exit "Version mismatch between vim, vim-python and vim-gtk."
	fi

	make distclean

	# Remove eventually existing symlinks from previous builds so that they get re-created.
	for link in eview evim ex gview gvim gvimdiff rgview rgvim rview rvim view vimdiff; do
		rm -f $NEOTERM_PREFIX/bin/$link
		rm -f $NEOTERM_PREFIX/share/man/man1/${link}.1*
	done
}

neoterm_step_post_make_install() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/vimrc $NEOTERM_PREFIX/share/vim/vimrc
	sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" $NEOTERM_PREFIX/share/vim/vimrc
	ln -sfr $NEOTERM_PREFIX/bin/vim $NEOTERM_PREFIX/bin/vi
}
