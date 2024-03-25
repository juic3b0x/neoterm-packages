NEOTERM_PKG_HOMEPAGE=https://packages.debian.org/sid/csh
NEOTERM_PKG_DESCRIPTION="C Shell with process control from 3BSD"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=20110502
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/c/csh/csh_${NEOTERM_PKG_VERSION}.orig.tar.gz
NEOTERM_PKG_SHA256=8bcba4fe796df1b9992e2d94e07ce6180abb24b55488384f9954aa61ecd8d68b
NEOTERM_PKG_DEPENDS="libandroid-glob, libbsd"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/LICENSE ./
}

neoterm_step_pre_configure() {
	CFLAGS="${CFLAGS/-Oz/-Os}"
	LDFLAGS+=" -Wl,-z,muldefs"
}

neoterm_step_post_configure() {
	make const.h
}

neoterm_step_post_make_install() {
	install -Dm600 -T ./csh.1 ${NEOTERM_PREFIX}/share/man/man1/csh.1
}
