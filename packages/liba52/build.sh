NEOTERM_PKG_HOMEPAGE=http://liba52.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A free library for decoding ATSC A/52 streams"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://distfiles.adelielinux.org/source/a52dec/a52dec-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=03c181ce9c3fe0d2f5130de18dab9bd8bc63c354071515aa56983c74a9cffcc9
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-djbfft
--disable-oss
"

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -lm"
}
