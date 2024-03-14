NEOTERM_PKG_HOMEPAGE=https://www.surina.net/soundtouch/
NEOTERM_PKG_DESCRIPTION="An open-source audio processing library for changing the Tempo, Pitch and Playback Rates of audio streams or files"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.2
NEOTERM_PKG_SRCURL=https://www.surina.net/soundtouch/soundtouch-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3bde8ddbbc3661f04e151f72cf21ca9d8f8c88e265833b65935b8962d12d6b08
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
