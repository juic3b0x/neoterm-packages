NEOTERM_PKG_HOMEPAGE=https://wiki.linuxquestions.org/wiki/Corkscrew
NEOTERM_PKG_DESCRIPTION="A tool for tunneling SSH through HTTP proxies"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/distfiles/releases/download/2021.01.04/corkscrew-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0d0fcbb41cba4a81c4ab494459472086f377f9edb78a2e2238ed19b58956b0be
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="openssh"

neoterm_step_post_make_install() {
	# Corkscrew does not distribute a man page, use one from debian:
	mkdir -p $NEOTERM_PREFIX/share/man/man1
	cp $NEOTERM_PKG_BUILDER_DIR/corkscrew.1 $NEOTERM_PREFIX/share/man/man1
}
