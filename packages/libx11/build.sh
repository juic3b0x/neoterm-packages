# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 client-side library"
NEOTERM_PKG_LICENSE="MIT, X11"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.8.7"
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libX11-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=05f267468e3c851ae2b5c830bcf74251a90f63f04dd7c709ca94dc155b7e99ee
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libxcb"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros, xtrans"
NEOTERM_PKG_RECOMMENDS="xorg-xauth"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_RAWCPP=/usr/bin/cpp
--enable-malloc0returnsnull
"

neoterm_step_post_massage() {
	# Regression test for broken XLC_LOCALE files. Do not remove.
	local f
	for f in share/X11/locale/*/XLC_LOCALE; do
		if [ ! -f "${f}" ]; then
			neoterm_error_exit "File not found: ${f}"
		fi
		if LC_ALL=C grep -E 'ct_encoding.*;\s*$' "${f}"; then
			neoterm_error_exit "Broken XLC_LOCALE file found: ${f}"
		fi
	done

	# Seems like some programs in the wild try to dlopen(3) `libX11.so.6`.
	cd ${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/lib || exit 1
	if [ ! -e "./libX11.so.6" ]; then
		ln -sf libX11.so libX11.so.6
	fi
}
