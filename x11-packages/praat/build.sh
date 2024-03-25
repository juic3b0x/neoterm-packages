NEOTERM_PKG_HOMEPAGE=https://www.praat.org
NEOTERM_PKG_DESCRIPTION="Doing phonetics by computer"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.4.06"
NEOTERM_PKG_SRCURL=https://github.com/praat/praat/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3656a907942fee6f98b41013cf9996cab3758a79b1781128be649b50fa7cdf38
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libc++, libcairo, pango, pulseaudio, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	rm -f meson.build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin praat
}
