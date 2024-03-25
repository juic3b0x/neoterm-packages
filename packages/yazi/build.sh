NEOTERM_PKG_HOMEPAGE=https://yazi-rs.github.io/
NEOTERM_PKG_DESCRIPTION="Blazing fast terminal file manager written in Rust, based on async I/O"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.2.4"
NEOTERM_PKG_SRCURL=https://github.com/sxyazi/yazi/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ded7c95f1c80301ba3c9f64443b840ef3607ed3782330aa3140269f31788d864
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cd $NEOTERM_PKG_SRCDIR
	cargo fetch --target "${CARGO_TARGET_NAME}"

	local _patch=$NEOTERM_PKG_BUILDER_DIR/tikv-jemalloc-sys-0.5.3+5.3.0-patched-src-lib.rs.diff
	local d
	for d in $CARGO_HOME/registry/src/*/tikv-jemalloc-sys-*; do
		patch --silent -p1 -d ${d} < ${_patch} || :
	done
}

neoterm_step_make() {
	YAZI_GEN_COMPLETIONS=true cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/yazi

	cd yazi-boot/completions
	install -Dm644 "${NEOTERM_PKG_NAME}".bash "${NEOTERM_PREFIX}"/share/bash-completion/completions/"${NEOTERM_PKG_NAME}".bash
	install -Dm644 _"${NEOTERM_PKG_NAME}" "${NEOTERM_PREFIX}"/share/zsh/site-functions/_"${NEOTERM_PKG_NAME}"
	install -Dm644 "${NEOTERM_PKG_NAME}".fish "${NEOTERM_PREFIX}"/share/fish/vendor_completions.d/"${NEOTERM_PKG_NAME}".fish
}

neoterm_step_create_debscripts() {
	cat <<- POSTINST_EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Please change font from neoterm-styling addon"
	POSTINST_EOF
}
