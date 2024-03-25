NEOTERM_PKG_HOMEPAGE="https://www.videolan.org/developers/libdvbcsa.html"
NEOTERM_PKG_DESCRIPTION="An implementation of the DVB Common Scrambling Algorithm - DVB/CSA - with encryption and decryption capabilities"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Aditya Alok <alok@neoterm.org>"
NEOTERM_PKG_VERSION=1.1.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL="https://download.videolan.org/pub/videolan/libdvbcsa/${NEOTERM_PKG_VERSION}/libdvbcsa-${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=4db78af5cdb2641dfb1136fe3531960a477c9e3e3b6ba19a2754d046af3f456d
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure(){
	autoreconf -fvi
}
