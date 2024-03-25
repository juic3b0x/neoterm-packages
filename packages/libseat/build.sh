NEOTERM_PKG_HOMEPAGE=https://sr.ht/~kennylevinsen/seatd/
NEOTERM_PKG_DESCRIPTION="Reference implementation of a wayland compositor"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.0"
NEOTERM_PKG_SRCURL=https://github.com/kennylevinsen/seatd/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a562a44ee33ccb20954a1c1ec9a90ecb2db7a07ad6b18d0ac904328efbcf65a0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Ddefaultpath=$NEOTERM_PREFIX/var/run/seatd.sock
"
