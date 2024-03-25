NEOTERM_PKG_HOMEPAGE=https://github.com/Parchive/par2cmdline
NEOTERM_PKG_DESCRIPTION="par2cmdline is a PAR 2.0 compatible file verification and repair tool"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
NEOTERM_PKG_VERSION=0.8.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/Parchive/par2cmdline/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=529f85857ec44e501cd8d95b0c8caf47477d7daa5bfb989e422c800bb71b689a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	if [ $NEOTERM_ARCH = "i686" ]; then
		# Avoid undefined reference to __atomic_* functions:
		export LIBS=" -latomic"
	fi
	aclocal
	automake --add-missing
	autoconf
}
