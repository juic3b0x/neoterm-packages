NEOTERM_PKG_HOMEPAGE=https://github.com/BYVoid/OpenCC
NEOTERM_PKG_DESCRIPTION="An opensource project for conversions between Traditional Chinese, Simplified Chinese and Japanese Kanji (Shinjitai)"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.1.7"
NEOTERM_PKG_SRCURL=https://github.com/BYVoid/OpenCC/archive/ver.${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=80a12675094a0cac90e70ee530e936dc76ca0953cb0443f7283c2b558635e4fe
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libc++, marisa"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DUSE_SYSTEM_MARISA=ON"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	neoterm_setup_cmake
	cmake $NEOTERM_PKG_SRCDIR
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_post_configure() {
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR/src/tools:$PATH
}
