NEOTERM_PKG_HOMEPAGE=https://github.com/rcr/rirc
NEOTERM_PKG_DESCRIPTION="A terminal IRC client in C"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.1.7"
NEOTERM_PKG_SRCURL=https://github.com/rcr/rirc/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b354d9859015809c4e5ef695c84110f96966351687cdb67b246a963e86d7602b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="ca-certificates, mbedtls"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	# Avoid duplicate definition of `struct user` (defined in <sys/user.h>):
	find . -type f -name '*.[ch]' | xargs -n 1 \
		sed -i -E 's/(struct user)($|[^_])/\1_\2/g'
	sed -i 's:CC       = cc::g' $NEOTERM_PKG_SRCDIR/Makefile
	sed -i 's:CFLAGS   =:CFLAGS   +=:g' $NEOTERM_PKG_SRCDIR/Makefile
	sed -i 's:LDFLAGS  =:LDFLAGS  +=:g' $NEOTERM_PKG_SRCDIR/Makefile
	sed -i "s:\$(DESTDIR)\$(PREFIX):${NEOTERM_PREFIX}:" $NEOTERM_PKG_SRCDIR/Makefile
}

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DMBEDTLS_ALLOW_PRIVATE_ACCESS"
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lmbedtls -lmbedx509 -lmbedcrypto"
}

neoterm_step_configure() {
	make config.h
}
