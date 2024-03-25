NEOTERM_PKG_HOMEPAGE=https://github.com/rogerbinns/apsw/
NEOTERM_PKG_DESCRIPTION="Another Python SQLite Wrapper"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.45.2.0"
NEOTERM_PKG_SRCURL=https://github.com/rogerbinns/apsw/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=20f3a49873e7c81410dd627f7e0cd86ccc5c28cdd398742ce1e0e97d95badf13
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libsqlite, python"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/setup.cfg ./
}

neoterm_step_make() {
	:
}
