NEOTERM_PKG_HOMEPAGE=https://devel.ringlet.net/editors/hexer/
NEOTERM_PKG_DESCRIPTION="A multi-buffer editor for binary files for Unix-like systems that displays its buffer(s) as a hex dump"
NEOTERM_PKG_LICENSE="non-free"
NEOTERM_PKG_LICENSE_FILE="COPYRIGHT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.6
NEOTERM_PKG_SRCURL=https://devel.ringlet.net/files/editors/hexer/hexer-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=e6b84ace5283825943f88ce7ec4ae836ec15ba41978b3a858d6d478cfe09ff94
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
PREFIX=$NEOTERM_PREFIX
MANDIR=$NEOTERM_PREFIX/share/man/man1
INSTALLBIN=install
"

neoterm_step_post_configure() {
	cat >> config.h <<-EOF
		#if defined __ANDROID__ && __ANDROID_API__ < 26
		#define getpwent() (NULL)
		#define setpwent() ((void)0)
		#endif
	EOF

	make CPPFLAGS= CFLAGS= LDFLAGS= bin2c
}
