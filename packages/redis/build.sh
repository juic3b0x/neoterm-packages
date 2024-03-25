NEOTERM_PKG_HOMEPAGE=https://redis.io/
NEOTERM_PKG_DESCRIPTION="In-memory data structure store used as a database, cache and message broker"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="7.2.4"
NEOTERM_PKG_SRCURL=https://download.redis.io/releases/redis-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=8d104c26a154b29fd67d6568b4f375212212ad41e0c2caa3d66480e78dbd3b59
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-execinfo, libandroid-glob"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFFILES="etc/redis.conf"

neoterm_step_pre_configure() {
	export PREFIX=$NEOTERM_PREFIX
	export USE_JEMALLOC=no

	CPPFLAGS+=" -DHAVE_BACKTRACE"
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -landroid-execinfo -landroid-glob"
}

neoterm_step_post_make_install() {
	install -Dm600 $NEOTERM_PKG_SRCDIR/redis.conf $NEOTERM_PREFIX/etc/redis.conf
}
