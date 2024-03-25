NEOTERM_PKG_HOMEPAGE=https://wasmer.io/
NEOTERM_PKG_DESCRIPTION="A fast and secure WebAssembly runtime"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="ATTRIBUTIONS, LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.2.6"
NEOTERM_PKG_SRCURL=https://github.com/wasmerio/wasmer/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d68af69391b1a8a4d3379e9282aa3bcf08b5daaeb2edce8d3317f518bda4d851
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_AUTO_UPDATE=true

# missing support in wasmer-emscripten, wasmer-vm
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_pre_configure() {
	# https://github.com/rust-lang/compiler-builtins#unimplemented-functions
	# https://github.com/rust-lang/rfcs/issues/2629
	# https://github.com/rust-lang/rust/issues/46651
	# https://github.com/juic3b0x/neoterm-packages/issues/8029
	RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	export WASMER_INSTALL_PREFIX="${NEOTERM_PREFIX}"
	neoterm_setup_rust
}

neoterm_step_make() {
	# https://github.com/wasmerio/wasmer/blob/master/Makefile
	# Makefile only does host builds
	# Dropping host build due to https://github.com/wasmerio/wasmer/issues/2822

	local compilers="cranelift"

	# TODO llvm-sys.rs crate has issues with libLLVM*.so as static archive
	#compilers+=",llvm"
	#export LLVM_VERSION=$(${NEOTERM_PREFIX}/bin/llvm-config --version)
	#export LLVM_SYS_140_PREFIX=$(${NEOTERM_PREFIX}/bin/llvm-config --prefix)

	case "${NEOTERM_ARCH}" in
	aarch64) compilers+=",singlepass" ;;
	x86_64) compilers+=",singlepass" ;;
	esac

	local compiler_features="${compilers},wasmer-artifact-create,static-artifact-create,wasmer-artifact-load,static-artifact-load"
	local capi_compiler_features="${compilers/,llvm/},wasmer-artifact-create,static-artifact-create,wasmer-artifact-load,static-artifact-load"

	echo "make build-wasmer"
	# https://github.com/wasmerio/wasmer/blob/master/lib/cli/Cargo.toml
	cargo build \
		--jobs "${NEOTERM_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--manifest-path lib/cli/Cargo.toml \
		--no-default-features \
		--features "wat,wast,${compiler_features}" \
		--bin wasmer

	echo "make build-capi"
	cargo build \
		--jobs "${NEOTERM_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--manifest-path lib/c-api/Cargo.toml \
		--no-default-features \
		--features "wat,compiler,wasi,middlewares,webc_runner,${capi_compiler_features}"

	echo "make build-wasmer-headless-minimal"
	RUSTFLAGS="${RUSTFLAGS} -C panic=abort" \
	cargo build \
		--jobs "${NEOTERM_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--manifest-path=lib/cli/Cargo.toml \
		--no-default-features \
		--features sys,headless-minimal \
		--bin wasmer-headless

	echo "make build-capi-headless"
	RUSTFLAGS="${RUSTFLAGS} -C panic=abort -C link-dead-code -C lto -O -C embed-bitcode=yes" \
	cargo build \
		--jobs "${NEOTERM_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--manifest-path lib/c-api/Cargo.toml \
		--no-default-features \
		--features compiler-headless,wasi,webc_runner \
		--target-dir target/headless
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}/bin" "target/${CARGO_TARGET_NAME}/release/wasmer"
	install -Dm755 -t "${NEOTERM_PREFIX}/bin" "target/${CARGO_TARGET_NAME}/release/wasmer-headless"

	for h in lib/c-api/*.h; do
		install -Dm644 "${h}" "${NEOTERM_PREFIX}"/include/$(basename "${h}")
	done
	# copy to share/doc/wasmer instead of include
	install -Dm644 "lib/c-api/README.md" "${NEOTERM_PREFIX}/share/doc/wasmer/wasmer-README.md"

	local shortver="${NEOTERM_PKG_VERSION%.*}"
	local majorver="${shortver%.*}"
	install -Dm644 "target/${CARGO_TARGET_NAME}/release/libwasmer.so" "${NEOTERM_PREFIX}/lib/libwasmer.so.${NEOTERM_PKG_VERSION}"
	ln -sf "libwasmer.so.${NEOTERM_PKG_VERSION}" "${NEOTERM_PREFIX}/lib/libwasmer.so.${shortver}"
	ln -sf "libwasmer.so.${NEOTERM_PKG_VERSION}" "${NEOTERM_PREFIX}/lib/libwasmer.so.${majorver}"
	ln -sf "libwasmer.so.${NEOTERM_PKG_VERSION}" "${NEOTERM_PREFIX}/lib/libwasmer.so"
	install -Dm644 "target/${CARGO_TARGET_NAME}/release/libwasmer.a" "${NEOTERM_PREFIX}/lib/libwasmer.a"

	install -Dm644 "target/headless/${CARGO_TARGET_NAME}/release/libwasmer.so" "${NEOTERM_PREFIX}/lib/libwasmer-headless.so"
	install -Dm644 "target/headless/${CARGO_TARGET_NAME}/release/libwasmer.a" "${NEOTERM_PREFIX}/lib/libwasmer-headless.a"

	# https://github.com/wasmerio/wasmer/blob/master/lib/cli/src/commands/config.rs
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/lib/pkgconfig/wasmer.pc"
	cat <<- EOF > "${NEOTERM_PREFIX}/lib/pkgconfig/wasmer.pc"
	prefix=${NEOTERM_PREFIX}
	exec_prefix=${NEOTERM_PREFIX}/bin
	includedir=${NEOTERM_PREFIX}/include
	libdir=${NEOTERM_PREFIX}/lib

	Name: wasmer
	Description: The Wasmer library for running WebAssembly
	Version: ${NEOTERM_PKG_VERSION}
	Cflags: -I${NEOTERM_PREFIX}/include
	Libs: -L${NEOTERM_PREFIX}/lib -lwasmer
	EOF

	cp ATTRIBUTIONS.md ATTRIBUTIONS

	unset LLVM_SYS_140_PREFIX LLVM_VERSION WASMER_INSTALL_PREFIX
}

neoterm_step_create_debscripts() {
	cat <<- EOL > postinst
	#1${NEOTERM_PREFIX}/bin/sh
	if [ -n "\$(command -v wapm)" ]; then
	echo "
	===== Post-install notice =====

	Upstream has deprecated 'wapm' package.
	You may want to remove 'wapm' package.

	===== Post-install notice =====
	"
	fi
	EOL
}
