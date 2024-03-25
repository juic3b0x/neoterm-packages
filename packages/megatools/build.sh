NEOTERM_PKG_HOMEPAGE=https://megatools.megous.com/
NEOTERM_PKG_DESCRIPTION="Open-source command line tools and C library (libmega) for accessing Mega.co.nz cloud storage"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.11.1.20230212
NEOTERM_PKG_SRCURL=https://megatools.megous.com/builds/megatools-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ecfa2ee4b277c601ebae648287311030aa4ca73ea61ee730bc66bef24ef19a34
NEOTERM_PKG_DEPENDS="glib, libandroid-support, libcurl, openssl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dsymlinks=true
"
