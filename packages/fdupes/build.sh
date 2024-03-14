NEOTERM_PKG_HOMEPAGE=https://github.com/adrianlopezroche/fdupes
NEOTERM_PKG_DESCRIPTION="Duplicates file detector"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/adrianlopezroche/fdupes/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8f38d21eb53e27a43f6652f0c6fa80c673f18466760281e812e84f56c1d359e3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libsqlite, ncurses, pcre2"

neoterm_step_pre_configure() {
	autoreconf --install
}
