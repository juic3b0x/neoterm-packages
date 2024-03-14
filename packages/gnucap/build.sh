NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gnucap/gnucap.html
NEOTERM_PKG_DESCRIPTION="The Gnu Circuit Analysis Package"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_VERSION=20210107
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://gitlab.com/gnucap/gnucap/-/archive/${NEOTERM_PKG_VERSION}/gnucap-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d2c24a66c7e60b379727c9e9487ed1b4a3532646b3f4cc03c6a4305749e3348b
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libc++, readline"
NEOTERM_PKG_BREAKS="gnucap-dev"
NEOTERM_PKG_REPLACES="gnucap-dev"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build () {
	cp -r $NEOTERM_PKG_SRCDIR/* .
	./configure
	(cd lib && make)
	(cd modelgen && make)
}

neoterm_step_pre_configure () {
	sed -i "s%@NEOTERM_PKG_HOSTBUILD_DIR@%$NEOTERM_PKG_HOSTBUILD_DIR%g" $NEOTERM_PKG_SRCDIR/apps/Make1
}

neoterm_step_configure () {
	$NEOTERM_PKG_SRCDIR/configure --prefix=$NEOTERM_PREFIX
}
