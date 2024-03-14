NEOTERM_PKG_HOMEPAGE="https://gitlab.inria.fr/gf2x/gf2x"
NEOTERM_PKG_DESCRIPTION="A library for multiplying polynomials over the binary field"
NEOTERM_PKG_GROUPS="science"
# Using file:'toom-gpl.c' enforces GPL license
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.0"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SRCURL="https://gitlab.inria.fr/gf2x/gf2x/-/archive/gf2x-$NEOTERM_PKG_VERSION/gf2x-gf2x-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=11bcf98b620c60c2ee3b4460b02b7be741f14cfdc26b542f22c92950926575e0

neoterm_step_pre_configure() {
	autoreconf -fi
}
