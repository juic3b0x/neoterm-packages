NEOTERM_PKG_HOMEPAGE="https://zellij.dev/"
NEOTERM_PKG_DESCRIPTION="A terminal workspace with batteries included"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Jonathan Lei <me@xjonathan.dev>"
NEOTERM_PKG_VERSION="0.39.2"
NEOTERM_PKG_SRCURL="https://github.com/zellij-org/zellij/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=feef552f06898fe06df00f9a590b862607266c087e804fffb638d2c46d9edad1
NEOTERM_PKG_BUILD_DEPENDS="zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

# wasmer doesn't support these platforms yet
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs ${NEOTERM_MAKE_PROCESSES} --target ${CARGO_TARGET_NAME} --release
}

neoterm_step_make_install() {
	install -Dm700 -t ${NEOTERM_PREFIX}/bin target/${CARGO_TARGET_NAME}/release/zellij

	install -Dm644 /dev/null ${NEOTERM_PREFIX}/share/bash-completion/completions/zellij.bash
	install -Dm644 /dev/null ${NEOTERM_PREFIX}/share/zsh/site-functions/_zellij
	install -Dm644 /dev/null ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/zellij.fish
}

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		zellij setup --generate-completion bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/zellij.bash
		zellij setup --generate-completion zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_zellij
		zellij setup --generate-completion fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/zellij.fish
	EOF
}
