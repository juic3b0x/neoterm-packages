NEOTERM_PKG_HOMEPAGE=https://github.com/hunspell/hyphen
NEOTERM_PKG_DESCRIPTION="hyphenation library to use converted TeX hyphenation patterns"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.8.8
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/hunspell/hyphen-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=304636d4eccd81a14b6914d07b84c79ebb815288c76fe027b9ebff6ff24d5705

neoterm_step_pre_configure() {
	autoreconf -fvi
} 
