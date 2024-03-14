NEOTERM_PKG_HOMEPAGE=https://www.nongnu.org/renameutils/
NEOTERM_PKG_DESCRIPTION="A set of programs designed to make renaming of files faster and less cumbersome"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.12.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://savannah.nongnu.org/download/renameutils/renameutils-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=cbd2f002027ccf5a923135c3f529c6d17fabbca7d85506a394ca37694a9eb4a3
NEOTERM_PKG_DEPENDS="libandroid-wordexp, readline"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-wordexp"
}
