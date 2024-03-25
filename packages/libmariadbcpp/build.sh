NEOTERM_PKG_HOMEPAGE=https://mariadb.com/docs/clients/mariadb-connectors/connector-cpp/
NEOTERM_PKG_DESCRIPTION="Enables C++ applications to establish client connections to MariaDB Enterprise over TLS"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.2
NEOTERM_PKG_SRCURL=git+https://github.com/mariadb-corporation/mariadb-connector-cpp
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_DEPENDS="libc++, openssl, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DINSTALL_LIB_SUFFIX=lib
-DINSTALL_LIBDIR=lib/mariadbcpp
-DINSTALL_PLUGINDIR=lib/mariadbcpp/plugin
-DINSTALL_DOCDIR=share/doc/$NEOTERM_PKG_NAME
-DINSTALL_LICENSEDIR=share/doc/$NEOTERM_PKG_NAME
-DWITH_EXTERNAL_ZLIB=ON
"

neoterm_step_pre_configure() {
	LDFLAGS="-Wl,-rpath=$NEOTERM_PREFIX/lib/mariadbcpp $LDFLAGS"
}
