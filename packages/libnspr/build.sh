NEOTERM_PKG_HOMEPAGE=https://hg.mozilla.org/projects/nspr
NEOTERM_PKG_DESCRIPTION="Netscape Portable Runtime (NSPR)"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.35
NEOTERM_PKG_SRCURL=https://archive.mozilla.org/pub/nspr/releases/v${NEOTERM_PKG_VERSION}/src/nspr-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7ea3297ea5969b5d25a5dd8d47f2443cda88e9ee746301f6e1e1426f8a6abc8f
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	NEOTERM_PKG_SRCDIR+="/nspr"
}

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DANDROID"
	LDFLAGS+=" -llog"

	if [ $NEOTERM_ARCH_BITS -eq 64 ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-64bit"
	fi

	NEOTERM_PKG_EXTRA_MAKE_ARGS+="
		NSINSTALL=$NEOTERM_PKG_HOSTBUILD_DIR/config/nsinstall
		NOW=$NEOTERM_PKG_HOSTBUILD_DIR/config/now
		"
}
