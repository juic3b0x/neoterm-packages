NEOTERM_PKG_HOMEPAGE=https://bs2b.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Bauer stereophonic-to-binaural DSP"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/bs2b/libbs2b-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=4799974becdeeedf0db00115bc63f60ea3fe4b25f1dfdb6903505839a720e46f
NEOTERM_PKG_DEPENDS="libc++, libsndfile"

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
