NEOTERM_PKG_HOMEPAGE=https://md5deep.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Programs to compute hashsums of arbitrary number of files recursively"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.4
NEOTERM_PKG_REVISION=8
NEOTERM_PKG_SRCURL=https://github.com/jessek/hashdeep/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ad78d42142f9a74fe8ec0c61bc78d6588a528cbb9aede9440f50b6ff477f3a7f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	sh bootstrap.sh
}
