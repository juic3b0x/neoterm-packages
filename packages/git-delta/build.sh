NEOTERM_PKG_HOMEPAGE=https://github.com/dandavison/delta
NEOTERM_PKG_DESCRIPTION="A syntax-highlighter for git and diff output"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Joshua Kahn @TomJo2000"
NEOTERM_PKG_VERSION="0.16.5"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/dandavison/delta/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=00d4740e9da4f543f34a2a0503615f8190d307d1180dfb753b6911aa6940197f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="git, libgit2, oniguruma"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	# There is a new `--generate-completion` option mentioned in the docs
	# The new completions are significantly better, but since they aren't
	# in a release yet we just cherry pick them from the commit
	# that introduces the option.
	# See: https://github.com/dandavison/delta/pull/1561
	#
	# Remove this once a version with with this feature gets released
	local COMPLETIONS_COMMIT='49a99180fed618b62ba773e3aebd8968b044262d'
	# Bash
	mkdir -p "$NEOTERM_PREFIX/share/bash-completion/completions"
	neoterm_download \
		"https://raw.githubusercontent.com/dandavison/delta/${COMPLETIONS_COMMIT}/etc/completion/completion.bash" \
		"$NEOTERM_PREFIX/share/bash-completion/completions/delta.bash" \
		'49ebca351567bdff17ebfa588a0fcf5da9af9530cb617fbb35c6c9c5ab07f46c'
	#Fish
	mkdir -p "$NEOTERM_PREFIX/share/fish/vendor_completions.d"
	neoterm_download \
		"https://raw.githubusercontent.com/dandavison/delta/${COMPLETIONS_COMMIT}/etc/completion/completion.fish" \
		"$NEOTERM_PREFIX/share/fish/vendor_completions.d/delta.fish" \
		'9f235b180d3237e66ef0a0300919daeccb601f0c5218d7a5d241a5b63535f4df'
	# Zsh
	mkdir -p "$NEOTERM_PREFIX/share/zsh/site-functions"
	neoterm_download \
		"https://raw.githubusercontent.com/dandavison/delta/${COMPLETIONS_COMMIT}/etc/completion/completion.zsh" \
		"$NEOTERM_PREFIX/share/zsh/site-functions/_delta" \
		'aaebecce15ac87dfbe57878842c79d7e1ac062f53981781a992b19412af51681'
}

neoterm_step_pre_configure() {
	export LIBGIT2_SYS_USE_PKG_CONFIG=1
	export RUSTONIG_SYSTEM_LIBONIG=1
	export PKG_CONFIG_ALLOW_CROSS=1

	rm -f Makefile release.Makefile
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu="-O2"

	local _ORIG_CFLAGS="$CFLAGS"
	neoterm_setup_rust
	export CFLAGS="$_ORIG_CFLAGS"

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in "$CARGO_HOME"/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done
}

neoterm_step_post_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin \
		"$NEOTERM_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/delta
}
