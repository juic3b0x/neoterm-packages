NEOTERM_PKG_HOMEPAGE=https://www.scintilla.org/SciTE.html
NEOTERM_PKG_DESCRIPTION="A free source code editor"
# License: HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="scite/License.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.4.3"
NEOTERM_PKG_SRCURL=https://www.scintilla.org/scite${NEOTERM_PKG_VERSION//./}.tgz
NEOTERM_PKG_SHA256=b27a13a3fd5376d7d0081e9aea865727080e7237f54dd9ac16e5209f8046b87d
NEOTERM_PKG_DEPENDS="at-spi2-core, gdk-pixbuf, glib, gtk3, libc++, libcairo, pango"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
CLANG=1
GTK3=1
NO_LUA=1
"

neoterm_extract_src_archive() {
	local file="$NEOTERM_PKG_CACHEDIR/$(basename "${NEOTERM_PKG_SRCURL}")"
	mkdir -p "$NEOTERM_PKG_SRCDIR"
	tar xf "$file" -C "$NEOTERM_PKG_SRCDIR" --strip-components=0
}

neoterm_step_pre_configure() {
	# https://github.com/juic3b0x/neoterm-packages/issues/18810
	LDFLAGS+=" -Wl,--undefined-version"
}

neoterm_step_make() {
	local d
	for d in lexilla/src scintilla/gtk scite/gtk; do
		make -j ${NEOTERM_MAKE_PROCESSES} -C ${d} \
			${NEOTERM_PKG_EXTRA_MAKE_ARGS}
	done
}

neoterm_step_make_install() {
	make -j ${NEOTERM_MAKE_PROCESSES} -C scite/gtk install \
		${NEOTERM_PKG_EXTRA_MAKE_ARGS}
}
