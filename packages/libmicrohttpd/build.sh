NEOTERM_PKG_HOMEPAGE=http://www.gnu.org/software/libmicrohttpd/
NEOTERM_PKG_DESCRIPTION="A small C library that is supposed to make it easy to run an HTTP server as part of another application"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9.77
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=9e7023a151120060d2806a6ea4c13ca9933ece4eacfc5c9464d20edddb76b0a0
NEOTERM_PKG_DEPENDS="libgnutls"
NEOTERM_PKG_BREAKS="libmicrohttpd-dev"
NEOTERM_PKG_REPLACES="libmicrohttpd-dev"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-examples
--enable-curl
--enable-https
--enable-largefile
--enable-messages"
