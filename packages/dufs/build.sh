NEOTERM_PKG_HOMEPAGE=https://github.com/sigoden/dufs
NEOTERM_PKG_DESCRIPTION="A file server that supports static serving, uploading, searching, accessing control, webdav..."
NEOTERM_PKG_LICENSE="Apache-2.0,MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-APACHE,LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.40.0"
NEOTERM_PKG_SRCURL=https://github.com/sigoden/dufs/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=da4b64add0df9fca1e38e416a8c265b57dc66e02d6256d1b34db12f9b5d7a962
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_post_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/dufs

	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/bash-completion/completions/dufs
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/zsh/site-functions/_dufs
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/fish/vendor_completions.d/dufs.fish
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh

	dufs --completions bash \
		> "$NEOTERM_PREFIX"/share/bash-completion/completions/dufs
	dufs --completions zsh \
		> "$NEOTERM_PREFIX"/share/zsh/site-functions/_dufs
	dufs --completions fish \
		> "$NEOTERM_PREFIX"/share/fish/vendor_completions.d/dufs.fish
	EOF
}
