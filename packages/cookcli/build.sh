NEOTERM_PKG_HOMEPAGE=https://cooklang.org
NEOTERM_PKG_DESCRIPTION="A suite of tools to create shopping lists and maintain food recipes"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.0"
NEOTERM_PKG_SRCURL=https://github.com/cooklang/cookcli/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=050fcbd7f8f938bd6ffc898a403795101807cfa6d76c787e991c8d90031405c6
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_nodejs
	neoterm_setup_rust

	# i686: __atomic_load
	if [[ "${NEOTERM_ARCH}" == "i686" ]]; then
		RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	fi
}

neoterm_step_make() {
	pushd ui
	npm install
	npm run build
	popd

	cargo build --jobs "${NEOTERM_MAKE_PROCESSES}" --target "${CARGO_TARGET_NAME}" --release
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}/bin" "target/${CARGO_TARGET_NAME}/release/cook"
}
