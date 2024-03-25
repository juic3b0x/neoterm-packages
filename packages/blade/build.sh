NEOTERM_PKG_HOMEPAGE=https://bladelang.com/
NEOTERM_PKG_DESCRIPTION="A simple, fast, clean and dynamic language"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.0.85"
NEOTERM_PKG_SRCURL=https://github.com/blade-lang/blade/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=039a9fe0c06a3a096362447b1172cf7eea23b5d414ea6cc25365d0d0147482ae
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_DEPENDS="libcurl, openssl"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	neoterm_setup_cmake
	cmake $NEOTERM_PKG_SRCDIR
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_pre_configure() {
	PATH=$NEOTERM_PKG_HOSTBUILD_DIR/blade:$PATH
	export LD_LIBRARY_PATH=$NEOTERM_PKG_HOSTBUILD_DIR/blade
}

neoterm_step_make_install() {
	pushd blade
	install -Dm700 -t $NEOTERM_PREFIX/bin blade
	install -Dm600 -t $NEOTERM_PREFIX/lib libblade.so
	local sharedir=$NEOTERM_PREFIX/share/blade
	mkdir -p $sharedir
	cp -r benchmarks includes libs tests $sharedir/
	popd
}
