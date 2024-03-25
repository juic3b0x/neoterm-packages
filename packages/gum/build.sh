NEOTERM_PKG_HOMEPAGE="https://github.com/charmbracelet/gum"
NEOTERM_PKG_DESCRIPTION="A tool for creating minimal interactive TUIs for shell scripts"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.13.0"
NEOTERM_PKG_SRCURL="https://github.com/charmbracelet/gum/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=329a38f3453b4be1f00e1fcb987aacf574fe3a8cc592084529c05716ddf4e7c4
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	cd "$NEOTERM_PKG_SRCDIR"
	export GOPATH="${NEOTERM_PKG_BUILDDIR}"
	go build
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}/bin" "${NEOTERM_PKG_SRCDIR}/gum"

	install -Dm644 /dev/null $NEOTERM_PREFIX/share/man/man1/gum.1
	install -Dm644 /dev/null $NEOTERM_PREFIX/share/bash-completion/completions/gum
	install -Dm644 /dev/null $NEOTERM_PREFIX/share/zsh/site-functions/_gum
	install -Dm644 /dev/null $NEOTERM_PREFIX/share/fish/vendor_completions.d/gum.fish
}

neoterm_step_create_debscripts() {
	# Note: the following lines should be indented with *tabs* (not spaces)
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh

	# Generating manpages
	printf >&2 "%s\n" "Generating manpages for gum"
	if ! gum man > "$NEOTERM_PREFIX/share/man/man1/gum.1"; then
		printf >&2 "\t%s\n" "manpages for gum: FAILED"
	fi

	# Generating shell completions
	printf >&2 "%s\n" "Generating shell completions for gum"
	if ! gum completion bash \
		> "$NEOTERM_PREFIX/share/bash-completion/completions/gum"; then
		printf >&2 "\t%s\n" "bash completions for gum: FAILED"
	fi
	if ! gum completion zsh \
		> "$NEOTERM_PREFIX/share/zsh/site-functions/_gum"; then
		printf >&2 "\t%s\n" "zsh completions for gum: FAILED"
	fi
	if ! gum completion fish \
		> "$NEOTERM_PREFIX/share/fish/vendor_completions.d/gum.fish"; then
		printf >&2 "\t%s\n" "fish completions for gum: FAILED"
	fi
	EOF
}
