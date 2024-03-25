NEOTERM_PKG_HOMEPAGE=https://www.kermitproject.org/ckermit.html
NEOTERM_PKG_DESCRIPTION="A combined network and serial communication software package"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="COPYING.TXT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=9.0.302
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=http://www.columbia.edu/kermit/ftp/archives/cku${NEOTERM_PKG_VERSION##*.}.tar.gz
NEOTERM_PKG_SHA256=0d5f2cd12bdab9401b4c836854ebbf241675051875557783c332a6a40dac0711
NEOTERM_PKG_DEPENDS="libcrypt"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-e linuxa"

neoterm_extract_src_archive() {
	local file="$NEOTERM_PKG_CACHEDIR/$(basename "${NEOTERM_PKG_SRCURL}")"
	mkdir -p "$NEOTERM_PKG_SRCDIR"
	tar xf "$file" -C "$NEOTERM_PKG_SRCDIR" --strip-components=0
}

neoterm_step_pre_configure() {
	CFLAGS+=" -fPIC"
	export KFLAGS="-DNOGETUSERSHELL -UNOTIMEH -DTIMEH -DUSE_FILE_R"
	LDFLAGS+=" -lcrypt"
	export LNKFLAGS="$LDFLAGS"
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/bin
	mkdir -p $NEOTERM_PREFIX/share/man
	make prefix=$NEOTERM_PREFIX manroot=$NEOTERM_PREFIX/share install
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/ckermit/ *.txt
}
