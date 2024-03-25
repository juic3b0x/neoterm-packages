NEOTERM_PKG_HOMEPAGE=https://www.codesink.org/mimetic_mime_library.html
NEOTERM_PKG_DESCRIPTION="A C++ Email library (MIME)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION=0.9.8
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.codesink.org/download/mimetic-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3a07d68d125f5e132949b078c7275d5eb0078dd649079bd510dd12b969096700
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
