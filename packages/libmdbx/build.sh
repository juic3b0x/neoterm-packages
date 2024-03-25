NEOTERM_PKG_HOMEPAGE=https://libmdbx.dqdkfa.ru/
NEOTERM_PKG_DESCRIPTION="An extremely fast, compact, powerful, embedded, transactional key-value database"
NEOTERM_PKG_LICENSE="OpenLDAP"
NEOTERM_PKG_LICENSE_FILE="COPYRIGHT, LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.12.7"
NEOTERM_PKG_SRCURL=git+https://gitflic.ru/project/erthink/libmdbx.git
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
