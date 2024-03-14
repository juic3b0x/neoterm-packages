NEOTERM_PKG_HOMEPAGE=https://www.sqlite.org
NEOTERM_PKG_DESCRIPTION="Library implementing a self-contained and transactional SQL database engine"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Note: Updating this version requires bumping libsqlite-tcl package as well.
_SQLITE_MAJOR=3
_SQLITE_MINOR=44
_SQLITE_PATCH=2
_SQLITE_YEAR=2023
NEOTERM_PKG_VERSION=${_SQLITE_MAJOR}.${_SQLITE_MINOR}.${_SQLITE_PATCH}
NEOTERM_PKG_SRCURL=https://www.sqlite.org/${_SQLITE_YEAR}/sqlite-autoconf-${_SQLITE_MAJOR}${_SQLITE_MINOR}0${_SQLITE_PATCH}00.tar.gz
NEOTERM_PKG_SHA256=1c6719a148bc41cf0f2bbbe3926d7ce3f5ca09d878f1246fcc20767b175bb407
NEOTERM_PKG_DEPENDS="zlib"
NEOTERM_PKG_BREAKS="libsqlite-dev"
NEOTERM_PKG_REPLACES="libsqlite-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-readline
--enable-fts3
"

neoterm_step_post_get_source() {
	# Version guard
	local ver_s=${NEOTERM_PKG_VERSION#*:}
	local ver_t=$(. $NEOTERM_SCRIPTDIR/packages/libsqlite-tcl/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	if [ "${ver_s}" != "${ver_t}" ]; then
		neoterm_error_exit "Version mismatch between libsqlite and libsqlite-tcl."
	fi
}

neoterm_step_pre_configure() {
	CPPFLAGS+=" -Werror -DSQLITE_ENABLE_DBSTAT_VTAB=1 -DSQLITE_ENABLE_COLUMN_METADATA=1 -DSQLITE_ENABLE_UPDATE_DELETE_LIMIT=1"
	LDFLAGS+=" -lm"
}
