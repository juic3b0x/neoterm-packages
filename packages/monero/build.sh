NEOTERM_PKG_HOMEPAGE=https://getmonero.org/
NEOTERM_PKG_DESCRIPTION="A private, secure, untraceable, decentralised digital currency"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.18.3.1
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=git+https://github.com/monero-project/monero
NEOTERM_PKG_DEPENDS="boost, libc++, libprotobuf, libsodium, libunbound, libusb, libzmq, miniupnpc, openssl, readline"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DReadline_ROOT_DIR=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	neoterm_setup_protobuf

	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"
	LDFLAGS+=" -lminiupnpc"
}

neoterm_step_post_configure() {
	local bin=$NEOTERM_PKG_BUILDDIR/_prefix/bin
	mkdir -p $bin
	$CC_FOR_BUILD \
		$NEOTERM_PKG_SRCDIR/translations/generate_translations_header.c \
		-o $bin/generate_translations_header_for_build
	export PATH=$bin:$PATH
}
