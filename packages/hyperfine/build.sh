NEOTERM_PKG_HOMEPAGE=https://github.com/sharkdp/hyperfine
NEOTERM_PKG_DESCRIPTION="A command-line benchmarking tool"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.18.0"
NEOTERM_PKG_SRCURL=https://github.com/sharkdp/hyperfine/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fea7b92922117ed04b9c84bb9998026264346768804f66baa40743c5528bed6b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_make_install() {
	# Manpages.
	install -Dm600 doc/"${NEOTERM_PKG_NAME}".1 \
		"${NEOTERM_PREFIX}"/share/man/man1/"${NEOTERM_PKG_NAME}".1

	# Shell completions.
	install -Dm600 target/"${CARGO_TARGET_NAME}"/release/build/"${NEOTERM_PKG_NAME}"*/out/"${NEOTERM_PKG_NAME}".bash \
		"${NEOTERM_PREFIX}"/share/bash-completion/completions/"${NEOTERM_PKG_NAME}".bash

	install -Dm600 target/"${CARGO_TARGET_NAME}"/release/build/"${NEOTERM_PKG_NAME}"*/out/"${NEOTERM_PKG_NAME}".fish \
		"${NEOTERM_PREFIX}"/share/fish/vendor_completions.d/"${NEOTERM_PKG_NAME}".fish

	install -Dm600 target/"${CARGO_TARGET_NAME}"/release/build/"${NEOTERM_PKG_NAME}"*/out/_"${NEOTERM_PKG_NAME}" \
		"${NEOTERM_PREFIX}"/share/zsh/site-functions/_"${NEOTERM_PKG_NAME}"
}
