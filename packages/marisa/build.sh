NEOTERM_PKG_HOMEPAGE=https://github.com/s-yata/marisa-trie
NEOTERM_PKG_DESCRIPTION="Matching Algorithm with Recursively Implemented StorAge"
NEOTERM_PKG_LICENSE="BSD 2-Clause, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2.6
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/s-yata/marisa-trie/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1063a27c789e75afa2ee6f1716cc6a5486631dcfcb7f4d56d6485d2462e566de
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# fix arm build and potentially other archs hidden bugs
	# ERROR: lib/libmarisa.so contains undefined symbols:
	# 39: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __aeabi_uidiv
	# 40: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __aeabi_idiv
	# 49: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __aeabi_idivmod
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
	autoreconf -fi
}
