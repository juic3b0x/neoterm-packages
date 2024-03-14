NEOTERM_PKG_HOMEPAGE=http://www.columbia.edu/kermit/gkermit.html
NEOTERM_PKG_DESCRIPTION="Simple, Portable, Free File Transfer Software for UNIX"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.01"
NEOTERM_PKG_SRCURL=https://www.kermitproject.org/ftp/kermit/archives/gku${NEOTERM_PKG_VERSION/./}.tar.gz
NEOTERM_PKG_SHA256=19f9ac00d7b230d0a841928a25676269363c2925afc23e62704cde516fc1abbd
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_MAKE_PROCESSES=1

neoterm_step_post_get_source() {
	local file filename
	filename=$(basename "$NEOTERM_PKG_SRCURL")
	file="$NEOTERM_PKG_CACHEDIR/$filename"
	tar xf "$file" -C "$NEOTERM_PKG_SRCDIR"
}
