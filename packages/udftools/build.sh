NEOTERM_PKG_HOMEPAGE=https://github.com/pali/udftools
NEOTERM_PKG_DESCRIPTION="Linux tools for UDF filesystems and DVD/CD-R(W) drives"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3
NEOTERM_PKG_SRCURL=https://github.com/pali/udftools/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=095e1c8b947849f5f8a1cade23dd3375532bda305a184eb022df96e43c4d6f7e
NEOTERM_PKG_DEPENDS="readline"

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_configure() {
	local f
	for f in "$NEOTERM_PKG_SRCDIR"/include/*.h; do
		ln -sf "${f}" ./include/
	done
}
