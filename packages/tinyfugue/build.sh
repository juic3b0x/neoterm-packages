NEOTERM_PKG_HOMEPAGE=https://tinyfugue.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Flexible, screen-oriented MUD client, for use with any type of MUD"
# License: GPL-2.0-or-later
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.0b8
NEOTERM_PKG_REVISION=2
_COMMIT=854c76f33a4eda6cd64e0b7dc3e07e5de8bbfada
NEOTERM_PKG_SRCURL=https://github.com/Longlius/tinyfugue/archive/${_COMMIT}.zip
NEOTERM_PKG_SHA256=59579de448b7e892a2b4dbfa7a7db7859382a90ec2bd77ce50c515358253461d
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="ncurses, openssl, pcre, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-termcap=ncurses
--disable-mailcheck
"

neoterm_step_pre_configure() {
	# CFLAGS are passed utilities built for host, but GCC
	# can't understand "-Oz".
	CFLAGS="${CFLAGS/-Oz/-Os}"
}
