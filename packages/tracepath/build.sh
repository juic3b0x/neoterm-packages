NEOTERM_PKG_HOMEPAGE=https://github.com/iputils/iputils
NEOTERM_PKG_DESCRIPTION="Tool to trace the network path to a remote host"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="20240117"
NEOTERM_PKG_SRCURL=https://github.com/iputils/iputils/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a5d66e2997945b2541b8f780a7f5a5ec895d53a517ae1dc4f3ab762573edea9a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d{8}"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	return
}

neoterm_step_make() {
	return
}

neoterm_step_make_install() {
	CPPFLAGS+=" -DPACKAGE_VERSION=\"$NEOTERM_PKG_VERSION\" -DHAVE_ERROR_H"
	$CC $CFLAGS $CPPFLAGS $LDFLAGS -o $NEOTERM_PREFIX/bin/tracepath iputils_common.c tracepath.c

	local MANDIR=$NEOTERM_PREFIX/share/man/man8
	mkdir -p $MANDIR
	cd $NEOTERM_PKG_SRCDIR/doc
	xsltproc \
		--stringparam man.output.quietly 1 \
		--stringparam funcsynopsis.style ansi \
		--stringparam man.th.extra1.suppress 1 \
		--stringparam iputils.version $NEOTERM_PKG_VERSION \
		custom-man.xsl \
		tracepath.xml
	cp tracepath.8 $MANDIR/

	# `traceroute` command is now provided by the package of the same name.
	# Please do not make `traceroute` an alias of `tracepath`.
}
