NEOTERM_PKG_HOMEPAGE=https://github.com/ellie/atuin
NEOTERM_PKG_DESCRIPTION="Magical shell history"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="../LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="18.0.2"
NEOTERM_PKG_SRCURL=https://github.com/ellie/atuin/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9be137bf3689ffdbd4acdaad39f0473c6bc81526819a3509c8f7d3090269b0f9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/atuin"
	NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR"

	# required to build for x86_64, see #8029
	export RUSTFLAGS="${RUSTFLAGS:-} -C link-args=$($CC -print-libgcc-file-name)"
}

neoterm_step_host_build() {
	export CC=""
	export CFLAGS=""
	export CPPFLAGS=""
	neoterm_setup_rust

	cd "$NEOTERM_PKG_SRCDIR"
	cargo build \
		--jobs $NEOTERM_MAKE_PROCESSES \
		--locked \
		--target-dir $NEOTERM_PKG_HOSTBUILD_DIR
}

neoterm_step_post_make_install() {
	# Generate and install shell completions
	mkdir completions/
	for sh in 'bash' 'fish' 'zsh'; do
		$NEOTERM_PKG_HOSTBUILD_DIR/debug/atuin gen-completions -s $sh -o completions/
	done

	install -Dm600 completions/atuin.bash $NEOTERM_PREFIX/share/bash-completion/completions/atuin.bash
	install -Dm600 completions/_atuin $NEOTERM_PREFIX/share/zsh/site-functions/_atuin
	install -Dm600 completions/atuin.fish $NEOTERM_PREFIX/share/fish/vendor_completions.d/atuin.fish
}
