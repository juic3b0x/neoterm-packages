NEOTERM_PKG_HOMEPAGE=https://mdocml.bsd.lv/
NEOTERM_PKG_DESCRIPTION="Man page viewer from the mandoc toolset"
NEOTERM_PKG_LICENSE="ISC, BSD 2-Clause, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.14.6
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=http://mdocml.bsd.lv/snapshots/mandoc-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8bf0d570f01e70a6e124884088870cbed7537f36328d512909eb10cd53179d9c
NEOTERM_PKG_DEPENDS="less,libandroid-glob,zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_RM_AFTER_INSTALL="share/examples"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DBIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD"
	LDFLAGS+=" -landroid-glob"
	echo "PREFIX=\"$NEOTERM_PREFIX\"" > configure.local
	echo "CC=\"$CC\"" >> configure.local
	echo "MANDIR=\"$NEOTERM_PREFIX/share/man\"" >> configure.local
	echo "CFLAGS=\"$CFLAGS -std=c99 -DNULL=0 $CPPFLAGS\"" >> configure.local
	echo "LDFLAGS=\"$LDFLAGS\"" >> configure.local
	for HAVING in HAVE_FGETLN HAVE_MMAP HAVE_STRLCAT HAVE_STRLCPY HAVE_SYS_ENDIAN HAVE_ENDIAN HAVE_NTOHL HAVE_NANOSLEEP HAVE_O_DIRECTORY HAVE_ISBLANK; do
		echo "$HAVING=1" >> configure.local
	done
	echo "HAVE_MANPATH=0" >> configure.local
	echo "HAVE_SQLITE3=1" >> configure.local
}

neoterm_step_create_debscripts() {
	[ "$NEOTERM_PACKAGE_FORMAT" != "pacman" ] && echo "interest-noawait $NEOTERM_PREFIX/share/man" > triggers

	echo "#!$NEOTERM_PREFIX/bin/sh" >> postinst
	echo "makewhatis -Q" >> postinst
	echo "exit 0" >> postinst
}
