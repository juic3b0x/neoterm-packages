NEOTERM_PKG_HOMEPAGE=https://timewarrior.net/
NEOTERM_PKG_DESCRIPTION="Command-line time tracker"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.1"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SRCURL=git+https://github.com/GothenburgBitFactory/timewarrior
NEOTERM_PKG_DEPENDS="libandroid-glob, libc++"

# Installation of man pages is broken as of version 1.4.3.
NEOTERM_PKG_RM_AFTER_INSTALL="share/man"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

