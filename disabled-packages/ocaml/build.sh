NEOTERM_PKG_HOMEPAGE=https://ocaml.org
NEOTERM_PKG_DESCRIPTION="Programming language supporting functional, imperative and object-oriented styles"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.02.3
NEOTERM_PKG_SRCURL=https://caml.inria.fr/pub/distrib/ocaml-${NEOTERM_PKG_VERSION:0:4}/ocaml-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=83c6697e135b599a196fd7936eaf8a53dd6b8f3155a796d18407b56f91df9ce3
NEOTERM_PKG_DEPENDS="pcre, openssl, libuuid"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	./configure -prefix $NEOTERM_PREFIX -mandir $NEOTERM_PREFIX/share/man/man1 -cc "$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		-host $NEOTERM_HOST_PLATFORM
}
