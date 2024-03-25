NEOTERM_PKG_HOMEPAGE=https://elixir-lang.org/
NEOTERM_PKG_DESCRIPTION="Elixir is a dynamic, functional language designed for building scalable and maintainable applications"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.16.2"
NEOTERM_PKG_SRCURL=https://github.com/elixir-lang/elixir/releases/download/v${NEOTERM_PKG_VERSION}/elixir-otp-25.zip
NEOTERM_PKG_SHA256=f5e7cd502ab25f0ae96fd1f347d26a8e9dcfe8f1b3f7d56aa5826f394af64b3d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="dash, erlang"
NEOTERM_PKG_SUGGESTS="clang, make"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_get_source() {
	neoterm_download "$NEOTERM_PKG_SRCURL" "$NEOTERM_PKG_CACHEDIR"/prebuilt.zip \
		"$NEOTERM_PKG_SHA256"
	# Create src directory to avoid build-package.sh errors.
	mkdir -p "$NEOTERM_PKG_SRCDIR"
}

neoterm_step_make_install() {
	# Unpack directly to $PREFIX/opt/elixir.
	mkdir -p "$NEOTERM_PREFIX"/opt
	rm -rf "$NEOTERM_PREFIX"/opt/elixir
	unzip -d "$NEOTERM_PREFIX"/opt/elixir "$NEOTERM_PKG_CACHEDIR"/prebuilt.zip

	# Remove unneeded files.
	(cd "$NEOTERM_PREFIX"/opt/elixir/man; rm -f common elixir.1.in iex.1.in)

	# Put manpages to standard location.
	for page in elixir.1 elixirc.1 iex.1 mix.1; do
		install -Dm600 "$NEOTERM_PREFIX/opt/elixir/man/$page" \
			"$NEOTERM_PREFIX/share/man/man1/$page"
	done
	unset page
	rm -rf "$NEOTERM_PREFIX"/opt/elixir/man

	# Symlink startup scripts to $PREFIX/bin.
	for file in elixir elixirc iex mix; do
		ln -sfr "$NEOTERM_PREFIX/opt/elixir/bin/$file" \
			"$NEOTERM_PREFIX/bin/$file"
	done
	unset file
}
