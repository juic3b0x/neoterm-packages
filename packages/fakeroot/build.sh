NEOTERM_PKG_HOMEPAGE=https://packages.qa.debian.org/f/fakeroot.html
NEOTERM_PKG_DESCRIPTION="Tool for simulating superuser privileges (with tcp ipc)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.34"
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_${NEOTERM_PKG_VERSION}.orig.tar.gz
NEOTERM_PKG_SHA256=5727f16d8903792588efa7a9f8ef8ce71f8756e746b62e45162e7735662e56bb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-ipc=tcp"
NEOTERM_PKG_BUILD_DEPENDS="libcap"

neoterm_step_pre_configure() {
	autoreconf -vfi

	CPPFLAGS+=" -D_ID_T"
}

neoterm_step_post_make_install() {
	ln -sfr "${NEOTERM_PREFIX}/lib/libfakeroot-0.so" "${NEOTERM_PREFIX}/lib/libfakeroot.so"
}

neoterm_step_create_debscripts() {
	{
		echo "#!$NEOTERM_PREFIX/bin/sh"
		echo "echo"
		echo "echo Fakeroot does not give you any real root permissions. This utility is primarily intended to be used for development purposes."
		echo "echo More info about usage at https://wiki.debian.org/FakeRoot."
		echo "echo"
		echo "echo Programs requiring real root permissions will not run under fakeroot. Do not post bug reports about this."
		echo "echo"
	} > ./postinst
}
