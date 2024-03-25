NEOTERM_PKG_HOMEPAGE=https://lilypond.org/
NEOTERM_PKG_DESCRIPTION="A music engraving program"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_LICENSE_FILE="COPYING, LICENSE, LICENSE.OFL"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.24.3"
NEOTERM_PKG_SRCURL=https://lilypond.org/download/sources/v${NEOTERM_PKG_VERSION%.*}/lilypond-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=df005f76ef7af5a4cd74a10f8e7115278b7fa79f14018937b65c109498ec44be
NEOTERM_PKG_DEPENDS="fontconfig, freetype, ghostscript, glib, guile, harfbuzz, libc++, pango, python, tex-gyre"
NEOTERM_PKG_BUILD_DEPENDS="flex"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-documentation
GUILE_FLAVOR=guile-3.0
PYTHON=python${NEOTERM_PYTHON_VERSION}
"

neoterm_step_post_make_install() {
	pushd $NEOTERM_PREFIX/share/lilypond
	local dst
	for dst in $(find . -type f -name "texgyre*.otf"); do
		local src="$NEOTERM_PREFIX/share/fonts/tex-gyre/$(basename "$dst")"
		if [ -e "$src" ]; then
			ln -sf "$src" "$dst"
		fi
	done
	popd
}
