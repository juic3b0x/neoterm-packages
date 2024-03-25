NEOTERM_PKG_HOMEPAGE=https://github.com/sass/sassc
NEOTERM_PKG_DESCRIPTION="libsass command line driver"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION=3.6.2
NEOTERM_PKG_SRCURL=https://github.com/sass/sassc/archive/refs/tags/${NEOTERM_PKG_VERSION}.zip
NEOTERM_PKG_SHA256=d9f8ae15894546fe973417ab85909fb70310de3a01a8a2d4c7a3182b03d5c6d7
NEOTERM_PKG_DEPENDS="libsass"

neoterm_step_pre_configure() {
	autoreconf -fi
}

