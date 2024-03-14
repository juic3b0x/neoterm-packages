NEOTERM_PKG_HOMEPAGE=https://profanity-im.github.io
NEOTERM_PKG_DESCRIPTION="Profanity is a console based XMPP client written in C using ncurses and libstrophe, inspired by Irssi"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
# This package depends on libpython${NEOTERM_PYTHON_VERSION}.so.
# Please revbump and rebuild when bumping NEOTERM_PYTHON_VERSION.
NEOTERM_PKG_VERSION="0.14.0"
NEOTERM_PKG_SRCURL=https://github.com/profanity-im/profanity/releases/download/$NEOTERM_PKG_VERSION/profanity-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=fd23ffd38a31907974a680a3900c959e14d44e16f1fb7df2bdb7f6c67bd7cf7f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, gpgme, libandroid-support, libassuan, libcurl, libgcrypt, libgpg-error, libotr, libsignal-protocol-c, libsqlite, libstrophe, ncurses, python, readline"
NEOTERM_PKG_BREAKS="profanity-dev"
NEOTERM_PKG_REPLACES="profanity-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS=" --enable-plugins --without-xscreensaver"
NEOTERM_PKG_BUILD_IN_SRC=true
