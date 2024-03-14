NEOTERM_PKG_HOMEPAGE=http://www.wagner.pp.ru/~vitus/software/catdoc/
NEOTERM_PKG_DESCRIPTION="Program which reads MS-Word file and prints readable ASCII text to stdout"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.95
NEOTERM_PKG_SRCURL=http://ftp.wagner.pp.ru/pub/catdoc/catdoc-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=514a84180352b6bf367c1d2499819dfa82b60d8c45777432fa643a5ed7d80796
NEOTERM_PKG_DEPENDS="libandroid-glob"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
