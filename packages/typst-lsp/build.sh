NEOTERM_PKG_HOMEPAGE=https://github.com/nvarner/typst-lsp
NEOTERM_PKG_DESCRIPTION="Language server for Typst"
NEOTERM_PKG_LICENSE="MIT, Apache-2.0"
NEOTERM_PKG_MAINTAINER="Joshua Kahn @TomJo2000"
NEOTERM_PKG_VERSION=0.12.1
NEOTERM_PKG_SRCURL=https://github.com/nvarner/typst-lsp/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=88c2053678147e6a3a01389644892f32244317f763622d19eaf7a64fe7e7e2dc
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# We're not shipping the VS Code plugin
	rm -rf .vscode
	neoterm_setup_rust
}
