NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gdb/
NEOTERM_PKG_DESCRIPTION="The standard GNU Debugger that runs on many Unix-like systems and works for many programming languages"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# This package depends on libpython${NEOTERM_PYTHON_VERSION}.so.
# Please revbump and rebuild when bumping NEOTERM_PYTHON_VERSION.
NEOTERM_PKG_VERSION="14.1"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gdb/gdb-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=d66df51276143451fcbff464cc8723d68f1e9df45a6a2d5635a54e71643edb80
NEOTERM_PKG_DEPENDS="guile, libc++, libexpat, libgmp, libiconv, liblzma, libmpfr, libthread-db, ncurses, python, readline, zlib, zstd"
NEOTERM_PKG_BREAKS="gdb-dev"
NEOTERM_PKG_REPLACES="gdb-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-shared
--disable-werror
--with-system-readline
--with-curses
--with-guile
--with-python=$NEOTERM_PREFIX/bin/python
ac_cv_func_getpwent=no
ac_cv_func_getpwnam=no
"
NEOTERM_PKG_RM_AFTER_INSTALL="share/gdb/syscalls share/gdb/system-gdbinit"
NEOTERM_PKG_MAKE_INSTALL_TARGET="-C gdb install"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		export ac_cv_guild_program_name=/usr/bin/guild-3.0
	fi

	# Fix "undefined reference to 'rpl_gettimeofday'" when building:
	export gl_cv_func_gettimeofday_clobber=no
	export gl_cv_func_gettimeofday_posix_signature=yes
	export gl_cv_func_realpath_works=yes
	export gl_cv_func_lstat_dereferences_slashed_symlink=yes
	export gl_cv_func_memchr_works=yes
	export gl_cv_func_stat_file_slash=yes
	export gl_cv_func_frexp_no_libm=no
	export gl_cv_func_strerror_0_works=yes
	export gl_cv_func_working_strerror=yes
	export gl_cv_func_getcwd_path_max=yes

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

neoterm_step_post_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin gdbserver/gdbserver
}
