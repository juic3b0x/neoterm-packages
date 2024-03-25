NEOTERM_PKG_HOMEPAGE=https://duckdb.org/
NEOTERM_PKG_DESCRIPTION="An in-process SQL OLAP database management system"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.0"
NEOTERM_PKG_AUTO_UPDATE=true
# we clone to retain the .git directory, to ensure the version in the built executable is correctly populated
NEOTERM_PKG_SRCURL=git+https://github.com/duckdb/duckdb
NEOTERM_PKG_DEPENDS="libc++, openssl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_EXTENSIONS='icu;parquet;httpfs;json;autocomplete' -DDUCKDB_EXPLICIT_PLATFORM=linux_arm64_android"

neoterm_step_pre_configure() {
	LDFLAGS+=" -llog"
	CXXFLAGS+=" -D_GLIBCXX_USE_CXX11_ABI=1"
}
