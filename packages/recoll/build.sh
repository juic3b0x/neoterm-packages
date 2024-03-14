NEOTERM_PKG_HOMEPAGE=https://www.lesbonscomptes.com/recoll/index.html
NEOTERM_PKG_DESCRIPTION="Full-text search for your desktop"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.37.4"
NEOTERM_PKG_SRCURL=https://www.lesbonscomptes.com/recoll/recoll-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3109d76a65bb2f887231b643994ed701c2efe6ba0771f8451b39e2f186c3b6ad
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="aspell, file, libc++, libiconv, libxapian, libxml2, libxslt, zlib"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_aspellProg=$NEOTERM_PREFIX/bin/aspell
--with-file-command=$NEOTERM_PREFIX/bin/file
--disable-userdoc
--disable-python-chm
--disable-python-aspell
--disable-x11mon
--disable-qtgui
"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
	CXXFLAGS+=" -fPIC"
	CPPFLAGS+=" -I${NEOTERM_PREFIX}/include/python${NEOTERM_PYTHON_VERSION}/"

	echo "Applying python-recoll-setup.py.in.diff"
	sed "s|@PYTHON_VERSION@|${NEOTERM_PYTHON_VERSION}|g" \
		$NEOTERM_PKG_BUILDER_DIR/python-recoll-setup.py.in.diff \
		| patch --silent -p1
}
