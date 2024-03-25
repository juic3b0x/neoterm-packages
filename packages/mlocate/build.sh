NEOTERM_PKG_HOMEPAGE=https://pagure.io/mlocate
NEOTERM_PKG_DESCRIPTION="Tool to find files anywhere in the filesystem based on their name"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# If not linking to libandroid-support we segfault in
# the libc mbsnrtowcs() function when using a wildcard
# like in '*.deb'.
NEOTERM_PKG_DEPENDS="libandroid-support"
NEOTERM_PKG_VERSION=0.26
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://releases.pagure.org/mlocate/mlocate-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3063df79fe198fb9618e180c54baf3105b33d88fe602ff2d8570aaf944f1263e

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX"
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "mkdir -p $NEOTERM_PREFIX/var/mlocate/" >> postinst
	echo "if [ ! -e $NEOTERM_PREFIX/var/mlocate/mlocate.db ]; then" >> postinst
	echo "  echo Remember to run \\\`updatedb\\'." >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
