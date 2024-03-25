NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/findutils/
NEOTERM_PKG_DESCRIPTION="Utilities to find files meeting specified criteria and perform various actions on the files which are found"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.9.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/findutils/findutils-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=a2bfb8c09d436770edc59f50fa483e785b161a3b7b9d547573cb08065fd462fe
NEOTERM_PKG_DEPENDS="libandroid-support"
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_GROUPS="base-devel"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
gl_cv_func_fflush_stdin=no
SORT_SUPPORTS_Z=yes
SORT=$NEOTERM_PREFIX/bin/sort
"

# Remove locale and updatedb which in NeoTerm is provided by mlocate:
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/locate
bin/updatedb
share/man/man1/locate.1
share/man/man1/updatedb.1
share/man/man5/locatedb.5
"

neoterm_step_pre_configure() {
	# This is needed for find to implement support for the
	# -fstype parameter by parsing /proc/self/mountinfo:
	CPPFLAGS+=" -DMOUNTED_GETMNTENT1=1"
}
