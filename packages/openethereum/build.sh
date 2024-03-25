NEOTERM_PKG_HOMEPAGE=https://openethereum.github.io
NEOTERM_PKG_DESCRIPTION="Lightweight Ethereum Client"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.5"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/openethereum/openethereum/archive/v${NEOTERM_PKG_VERSION}.zip
NEOTERM_PKG_SHA256=fb4a3c9ac1e5ba2803098b3ba1c114a2a9a5397fed3cd65c4c966525cb6b075d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	neoterm_setup_cmake

	CXXFLAGS+=" --target=$CCNEOTERM_HOST_PLATFORM"
	CFLAGS+=" --target=$CCNEOTERM_HOST_PLATFORM"
	if [ $NEOTERM_ARCH = "arm" ]; then
		CFLAGS="${CFLAGS/-mthumb/}"
		CMAKE_SYSTEM_PROCESSOR="armv7-a"
	else
		CMAKE_SYSTEM_PROCESSOR=$NEOTERM_ARCH
	fi

	cat <<- EOF > $NEOTERM_COMMON_CACHEDIR/defaultcache.cmake
		CMAKE_CROSSCOMPILING=ON
		CMAKE_LINKER="$NEOTERM_STANDALONE_TOOLCHAIN/bin/$LD $LDFLAGS"
		CMAKE_SYSTEM_NAME=Android
		CMAKE_SYSTEM_VERSION=$NEOTERM_PKG_API_LEVEL
		CMAKE_SYSTEM_PROCESSOR=$CMAKE_SYSTEM_PROCESSOR
		CMAKE_ANDROID_STANDALONE_TOOLCHAIN=$NEOTERM_STANDALONE_TOOLCHAIN

		CMAKE_AR="$(command -v $AR)"
		CMAKE_UNAME="$(command -v uname)"
		CMAKE_RANLIB="$(command -v $RANLIB)"
		CMAKE_C_FLAGS="$CFLAGS -Wno-error=shadow $CPPFLAGS"
		CMAKE_CXX_FLAGS="$CXXFLAGS $CPPFLAGS"
		CMAKE_FIND_ROOT_PATH=$NEOTERM_PREFIX
		CMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER
		CMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY
		CMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY
		CMAKE_SKIP_INSTALL_RPATH=ON
		CMAKE_USE_SYSTEM_LIBRARIES=ON
		BUILD_TESTING=OFF

		WITH_GFLAGS=OFF
	EOF

	export CMAKE=$NEOTERM_PKG_BUILDER_DIR/cmake_mod.sh
	export NEOTERM_COMMON_CACHEDIR

	neoterm_setup_rust
	cargo clean
	export NDK_HOME=$NDK
	RUSTFLAGS+=" -C link-args=-lc++"
	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	if [ "$NEOTERM_ARCH" = "x86_64" ]; then
		local libdir=target/$CARGO_TARGET_NAME/release/deps
		mkdir -p $libdir
		pushd $libdir
		RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
		echo "INPUT(-l:libunwind.a)" > libgcc.so
		popd
	fi
}

neoterm_step_make() {
	cargo fetch --target $CARGO_TARGET_NAME
	patch --silent -p1 \
		-d $CARGO_HOME/registry/src/*/parity-rocksdb-sys-0.5.6/rocksdb \
		< $NEOTERM_PKG_BUILDER_DIR/parity-rocksdb-sys-0.5.6-mutex.diff
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --features final
	for applet in evmbin ethstore-cli ethkey-cli; do
		cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release -p $applet
	done
}

neoterm_step_make_install() {
	for applet in openethereum openethereum-evm ethstore ethkey; do
		install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/$applet
	done
}
