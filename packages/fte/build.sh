NEOTERM_PKG_HOMEPAGE=https://fte.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A free text editor for developers"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=20110708
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=(https://downloads.sourceforge.net/fte/fte-${NEOTERM_PKG_VERSION}-src.zip
                   https://downloads.sourceforge.net/fte/fte-${NEOTERM_PKG_VERSION}-common.zip)
NEOTERM_PKG_SHA256=(d6311c542d3f0f2890a54a661c3b67228e27b894b4164e9faf29f014f254499e
                   58411578b31958765f42d2bf29b7aedd9f916955c2c19c96909a1c03e0246af7)
NEOTERM_PKG_DEPENDS="libc++, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
TARGETS=nfte
INSTALL_NONROOT=1
PREFIX=$NEOTERM_PREFIX
"
NEOTERM_PKG_HOSTBUILD=true

neoterm_extract_src_archive() {
	rm -Rf fte
	for i in $(seq 0 $(( ${#NEOTERM_PKG_SRCURL[@]}-1 ))); do
		unzip -q "$NEOTERM_PKG_CACHEDIR/$(basename "${NEOTERM_PKG_SRCURL[$i]}")"
	done
	mv fte "$NEOTERM_PKG_SRCDIR"
}

neoterm_step_host_build() {
	find "$NEOTERM_PKG_SRCDIR" -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;
	make CC="gcc -m${NEOTERM_ARCH_BITS}" LDFLAGS="-m${NEOTERM_ARCH_BITS}" \
		TARGETS=cfte
}

neoterm_step_pre_configure() {
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR/src:$PATH

	CPPFLAGS+=" -DHAVE_STRLCPY -DHAVE_STRLCAT"

	echo '#include_next <ncurses.h>' > "$NEOTERM_PKG_SRCDIR"/src/ncurses.h
}
