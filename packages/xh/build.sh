NEOTERM_PKG_HOMEPAGE=https://github.com/ducaale/xh
NEOTERM_PKG_DESCRIPTION="A friendly and fast tool for sending HTTP requests"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.21.0"
NEOTERM_PKG_SRCURL=https://github.com/ducaale/xh/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7e6b91a46bbbfee3907bf06d224a2e66a92b8f3e3950de43de5f06ce3beaacec
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/xh
	ln -sf $NEOTERM_PREFIX/bin/xh{,s}

	install -Dm600 doc/xh.1 "${NEOTERM_PREFIX}"/share/man/man1/xh.1
	install -Dm644 completions/xh.bash "${NEOTERM_PREFIX}"/share/bash-completion/completions/xh.bash
	install -Dm644 completions/_xh "${NEOTERM_PREFIX}"/share/zsh/site-functions/_xh
	install -Dm644 completions/xh.fish "${NEOTERM_PREFIX}"/share/fish/vendor_completions.d/xh.fish
}
