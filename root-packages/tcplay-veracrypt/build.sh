NEOTERM_PKG_HOMEPAGE=https://github.com/bwalex/tc-play
NEOTERM_PKG_DESCRIPTION="Free and simple TrueCrypt implementation based on dm-crypt."
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.3
NEOTERM_PKG_SRCURL=https://github.com/bwalex/tc-play/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ad53cd814a23b4f61a1b2b6dc2539624ffb550504c400c45cbd8cd1da4c7d90a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libdevmapper, libuuid, libgcrypt"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DLIB_SUFFIX=
"
