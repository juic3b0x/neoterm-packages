NEOTERM_PKG_HOMEPAGE=https://mosh.org
NEOTERM_PKG_DESCRIPTION="Mobile shell that supports roaming and intelligent local echo"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4.0
NEOTERM_PKG_REVISION=8
NEOTERM_PKG_SRCURL=https://github.com/mobile-shell/mosh/releases/download/mosh-${NEOTERM_PKG_VERSION}/mosh-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=872e4b134e5df29c8933dff12350785054d2fd2839b5ae6b5587b14db1465ddd
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="abseil-cpp, libandroid-support, libc++, libprotobuf, ncurses, openssl, openssh"
NEOTERM_PKG_SUGGESTS="mosh-perl"

neoterm_step_pre_configure() {
	neoterm_setup_protobuf

	CXXFLAGS+=" -std=c++14"
	LDFLAGS+=" $($NEOTERM_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
}

neoterm_step_post_make_install() {
	cd $NEOTERM_PREFIX/bin
	mv mosh mosh.pl
	$CXX $CXXFLAGS $LDFLAGS \
		-isystem $NEOTERM_PREFIX/include \
		-DPACKAGE_VERSION=\"$NEOTERM_PKG_VERSION\" \
		-std=c++11 -Wall -Wextra -Werror \
		$NEOTERM_PKG_BUILDER_DIR/mosh.cc -o mosh-bin
	cat <<-EOF > mosh
		#!$NEOTERM_PREFIX/bin/sh
		if [ -e "$NEOTERM_PREFIX/bin/mosh.pl" ]; then
			exec "$NEOTERM_PREFIX/bin/mosh.pl" "\$@"
		else
			exec "$NEOTERM_PREFIX/bin/mosh-bin" "\$@"
		fi
	EOF
	chmod 0700 mosh
}
