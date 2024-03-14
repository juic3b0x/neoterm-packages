NEOTERM_PKG_HOMEPAGE=https://github.com/rossmacarthur/sheldon
NEOTERM_PKG_DESCRIPTION="Fast, configurable, shell plugin manager"
NEOTERM_PKG_LICENSE="MIT, Apache-2.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.4"
NEOTERM_PKG_SRCURL=https://github.com/rossmacarthur/sheldon/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5d8ecd432a99852d416580174be7ab8f29fe9231d9804f0cc26ba2b158f49cdf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcurl, libssh2, openssl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export LIBSSH2_SYS_USE_PKG_CONFIG=1
	export PKG_CONFIG_ALLOW_CROSS=1
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}"/bin target/${CARGO_TARGET_NAME}/release/sheldon

	# completions
	install -Dm644 completions/sheldon.bash "${NEOTERM_PREFIX}/share/bash-completion/completions/sheldon"
	install -Dm644 completions/sheldon.zsh "${NEOTERM_PREFIX}/share/zsh/site-functions/_sheldon"
}
