NEOTERM_PKG_HOMEPAGE=https://www.jython.org/
NEOTERM_PKG_DESCRIPTION="Python for the Java Platform"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.7.3
NEOTERM_PKG_SRCURL=https://github.com/jython/jython/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d037f437bb1c6399c1c1521320f8775a085a99e6bec7f83c6c9e4ef2e40b19e8
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_BUILD_DEPENDS="ant"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_RM_AFTER_INSTALL="
opt/jython/bin/jython_regrtest.bat
opt/jython/bin/jython.exe
opt/jython/bin/jython.py
"

neoterm_step_make() {
	sh $NEOTERM_PREFIX/bin/ant
}

neoterm_step_make_install() {
	rm -rf $NEOTERM_PREFIX/opt/jython
	mkdir -p $NEOTERM_PREFIX/opt/jython
	cp -a $NEOTERM_PKG_SRCDIR/dist/* $NEOTERM_PREFIX/opt/jython/
	ln -sfr $NEOTERM_PREFIX/opt/jython/bin/jython $NEOTERM_PREFIX/bin/jython
}
