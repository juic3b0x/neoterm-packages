NEOTERM_PKG_HOMEPAGE=https://github.com/sharkdp/fd
NEOTERM_PKG_DESCRIPTION="Simple, fast and user-friendly alternative to find"
NEOTERM_PKG_LICENSE="Apache-2.0,MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-APACHE,LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="9.0.0"
NEOTERM_PKG_SRCURL=https://github.com/sharkdp/fd/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=306d7662994e06e23d25587246fa3fb1f528579e42a84f5128e75feec635a370
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/fd

	install -Dm644 /dev/null "${NEOTERM_PREFIX}"/share/bash-completion/completions/"${NEOTERM_PKG_NAME}".bash
	install -Dm644 /dev/null "${NEOTERM_PREFIX}"/share/zsh/site-functions/_"${NEOTERM_PKG_NAME}"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}"/share/fish/vendor_completions.d/"${NEOTERM_PKG_NAME}".fish
}

neoterm_step_post_make_install() {
	# Manpages.
	install -Dm600 doc/"${NEOTERM_PKG_NAME}".1 \
		"${NEOTERM_PREFIX}"/share/man/man1/"${NEOTERM_PKG_NAME}".1
	
	install -Dm600 contrib/completion/_"${NEOTERM_PKG_NAME}" \
		"${NEOTERM_PREFIX}"/share/zsh/site-functions/_"${NEOTERM_PKG_NAME}"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		fd --gen-completions bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/fd.bash
		fd --gen-completions fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/fd.fish
	EOF
}
