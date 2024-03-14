NEOTERM_PKG_HOMEPAGE=https://os.ghalkes.nl/libtranscript.html
NEOTERM_PKG_DESCRIPTION="A character-set conversion library"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://os.ghalkes.nl/dist/libtranscript-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=1f8c19f257da5d6fad0ed9a7e5bd2442819e910a19907c38e115116a3955f5fa
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"

neoterm_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
}

neoterm_step_pre_configure() {
	local libtooldir=$NEOTERM_PKG_TMPDIR/_libtool
	mkdir -p $libtooldir
	pushd $libtooldir
	cat > configure.ac <<-EOF
		AC_INIT
		LT_INIT
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$NEOTERM_SCRIPTDIR/scripts/config.sub" ./
	cp "$NEOTERM_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$NEOTERM_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool
}
