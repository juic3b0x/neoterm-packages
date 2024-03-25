NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/neoterm-packages
NEOTERM_PKG_DESCRIPTION="Fake ldd command"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_DEPENDS="bash, binutils-bin"
NEOTERM_PKG_CONFLICTS="binutils (<< 2.39-1)"

neoterm_step_make_install() {
	local _READELF=$NEOTERM_PREFIX/libexec/binutils/readelf

	local ldd="$NEOTERM_PREFIX/bin/ldd"
	mkdir -p "$(dirname "${ldd}")"
	rm -rf "${ldd}"
	sed "$NEOTERM_PKG_BUILDER_DIR/ldd.in" \
		-e "s|@ARCH_BITS@|${NEOTERM_ARCH_BITS}|g" \
		-e "s|@READELF@|${_READELF}|g" \
		> "${ldd}"
	chmod 0700 "${ldd}"
}
