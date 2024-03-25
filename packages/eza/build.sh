NEOTERM_PKG_HOMEPAGE=https://github.com/eza-community/eza
NEOTERM_PKG_DESCRIPTION="A modern replacement for ls"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.18.6"
NEOTERM_PKG_SRCURL=https://github.com/eza-community/eza/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4cbca009d8ddc817d9ffda34bd1cada4278896e63051c645f0821605a6497faa
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libgit2"
NEOTERM_PKG_BREAKS="exa"
NEOTERM_PKG_REPLACES="exa"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in $CARGO_HOME/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done

	CFLAGS="$CPPFLAGS"
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/man/man{1,5}
	pandoc --standalone --to man $NEOTERM_PKG_SRCDIR/man/eza.1.md --output $NEOTERM_PREFIX/share/man/man1/eza.1
	pandoc --standalone --to man $NEOTERM_PKG_SRCDIR/man/eza_colors.5.md --output $NEOTERM_PREFIX/share/man/man5/eza_colors.5
	install -Dm600 completions/bash/eza $NEOTERM_PREFIX/share/bash-completion/completions/eza
	install -Dm600 completions/fish/eza.fish $NEOTERM_PREFIX/share/fish/vendor_completions.d/eza.fish
	install -Dm600 completions/zsh/_eza $NEOTERM_PREFIX/share/zsh/site-functions/_eza
}

neoterm_step_create_debscripts() {
	# This is a temporary notice and should be removed in the future
	cat <<- POSTINST_EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/bash

		echo "===Package replacement notice==="
		echo "exa has been replaced, by it's maintained community fork eza."
		echo
		echo "See:"
		echo "https://github.com/ogham/exa#exa-is-unmaintained-use-the-fork-eza-instead"
		echo "For more information."
		echo
		echo "Your options and aliases for exa may need to be updated"
		echo "================================"
		echo

	exit 0
	POSTINST_EOF

	chmod 0755 postinst

	if [[ "$NEOTERM_PACKAGE_FORMAT" == "pacman" ]]; then
		echo "post_install" > postupg
	fi
}

