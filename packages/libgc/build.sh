NEOTERM_PKG_HOMEPAGE=https://www.hboehm.info/gc/
NEOTERM_PKG_DESCRIPTION="Library providing the Boehm-Demers-Weiser conservative garbage collector"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="README.QUICK"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=8.2.6
NEOTERM_PKG_SRCURL=https://github.com/ivmai/bdwgc/releases/download/v$NEOTERM_PKG_VERSION/gc-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=b9183fe49d4c44c7327992f626f8eaa1d8b14de140f243edb1c9dcff7719a7fc
NEOTERM_PKG_BREAKS="libgc-dev"
NEOTERM_PKG_REPLACES="libgc-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-libatomic-ops=none"
NEOTERM_PKG_RM_AFTER_INSTALL="share/gc"

neoterm_step_post_get_source() {
	./autogen.sh
}
