NEOTERM_PKG_HOMEPAGE=http://pkgconf.org
NEOTERM_PKG_DESCRIPTION="Program which helps to configure compiler and linker flags for development frameworks"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.3
NEOTERM_PKG_SRCURL=https://github.com/pkgconf/pkgconf/archive/pkgconf-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=45b76f5037379b1e24b788379c74f31fc4f060b272a08bdda9e558c120e9f3b6

neoterm_step_pre_configure() {
	./autogen.sh
}
