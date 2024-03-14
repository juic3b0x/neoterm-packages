NEOTERM_PKG_HOMEPAGE=https://github.com/mitnk/cicada
NEOTERM_PKG_DESCRIPTION="A bash like Unix shell"
NEOTERM_PKG_MAINTAINER="Hugo Wang <w@mitnk.com>"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_VERSION="0.9.38"
NEOTERM_PKG_SRCURL=https://github.com/mitnk/cicada/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=7ba8980a53707549b35a274b0a332623e79d419109c427d2481e2ffcc7d4ba3a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_pre_configure() {
	rm -f Makefile

	if [ "$NEOTERM_ARCH" == "x86_64" ]; then
		local libdir=target/x86_64-linux-android/release/deps
		mkdir -p $libdir
		pushd $libdir
		RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
		echo "INPUT(-l:libunwind.a)" > libgcc.so
		popd
	fi
}
