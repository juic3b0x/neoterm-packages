NEOTERM_PKG_HOMEPAGE=https://github.com/kainjow/Mustache
NEOTERM_PKG_DESCRIPTION="Mustache implementation for modern C++"
NEOTERM_PKG_LICENSE="BSL-1.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.1
NEOTERM_PKG_SRCURL=https://github.com/kainjow/Mustache/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=acd66359feb4318b421f9574cfc5a511133a77d916d0b13c7caa3783c0bfe167
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_configure() {
	:
}

neoterm_step_make() {
	:
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/include $NEOTERM_PKG_SRCDIR/mustache.hpp
}
