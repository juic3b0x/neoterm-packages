NEOTERM_PKG_HOMEPAGE=https://github.com/imageworks/pystring
NEOTERM_PKG_DESCRIPTION="C++ functions matching the interface and behavior of python string methods with std::string"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.4
NEOTERM_PKG_SRCURL=https://github.com/imageworks/pystring/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=49da0fe2a049340d3c45cce530df63a2278af936003642330287b68cefd788fb
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/include/pystring \
		$NEOTERM_PKG_SRCDIR/pystring.h
}
