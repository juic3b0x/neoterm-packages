NEOTERM_PKG_HOMEPAGE=https://www.giuspen.net/cherrytree/
NEOTERM_PKG_DESCRIPTION="A hierarchical note taking application"
NEOTERM_PKG_LICENSE="GPL-3.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.4"
NEOTERM_PKG_SRCURL=https://github.com/giuspen/cherrytree/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=54c4d483125fa20fa7ebca336606570ecd2b150d48d7630480c92dc523c4241a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fribidi, glib, gspell, gtk3, gtkmm3, gtksourceview3, libatkmm-1.6, libc++, libcairo, libcairomm-1.0, libcurl, libglibmm-2.4, libgtksourceviewmm-3.0, libpangomm-1.4, libsigc++-2.0, libsqlite, libuchardet, libvte, libxml++-2.6, libxml2, pango"
NEOTERM_PKG_BUILD_DEPENDS="fmt, libspdlog"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTING=OFF
-DUSE_NLS=OFF
-DUSE_SHARED_FMT_SPDLOG=ON
"
