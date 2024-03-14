NEOTERM_PKG_HOMEPAGE=https://www.oracle.com/database/berkeley-db
NEOTERM_PKG_DESCRIPTION="The Berkeley DB embedded database system (library)"
NEOTERM_PKG_LICENSE="AGPL-V3"
# We override NEOTERM_PKG_SRCDIR neoterm_step_pre_configure so need to do
# this hack to be able to find the license file.
NEOTERM_PKG_LICENSE_FILE="../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=18.1.40
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/db-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0cecb2ef0c67b166de93732769abdeba0555086d51de1090df325e18ee8da9c8
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="libdb-dev"
NEOTERM_PKG_REPLACES="libdb-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-hash
--enable-smallbuild
--enable-compat185
db_cv_atomic=gcc-builtin
--enable-cxx
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR/dist

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
