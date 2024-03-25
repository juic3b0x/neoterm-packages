NEOTERM_PKG_HOMEPAGE=https://seafile.com
NEOTERM_PKG_DESCRIPTION="Seafile is a file syncing and sharing software with file encryption and group sharing"
# License: GPL-2.0-with-OpenSSL-exception
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="9.0.5"
NEOTERM_PKG_SRCURL=https://github.com/haiwen/seafile/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9a1743784fda646cd7713b5d7eb8a685372ca46c61db1f484037bf5a1f01b7ce
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="glib, libcurl, libevent, libjansson, libsearpc, libsqlite, libuuid, libwebsockets, openssl, python, zlib"
NEOTERM_PKG_BREAKS="seafile-client-dev, ccnet"
NEOTERM_PKG_REPLACES="seafile-client-dev, ccnet"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SETUP_PYTHON=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-python_prefix=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	./autogen.sh
	export CPPFLAGS="-I$NEOTERM_PKG_SRCDIR/lib $CPPFLAGS"
}

neoterm_step_post_configure() {
	#the package has trouble to prepare some headers
	cd $NEOTERM_PKG_SRCDIR/lib
	python $NEOTERM_PREFIX/bin/searpc-codegen.py $NEOTERM_PKG_SRCDIR/lib/rpc_table.py
}
