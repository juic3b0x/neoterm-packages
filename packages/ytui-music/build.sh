NEOTERM_PKG_HOMEPAGE=https://github.com/sudipghimire533/ytui-music
NEOTERM_PKG_DESCRIPTION="Youtube client in terminal for music"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.0-beta
NEOTERM_PKG_SRCURL=https://github.com/sudipghimire533/ytui-music/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=43deb6b3cb9eb836b7122ac2542106f46519f240f99a0af67eecdfa5b200cca7
NEOTERM_PKG_DEPENDS="libsqlite, mpv, openssl, python-pip"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export OPENSSL_INCLUDE_DIR=$NEOTERM_PREFIX/include/openssl
	export OPENSSL_LIB_DIR=$NEOTERM_PREFIX/lib

	NEOTERM_PKG_SRCDIR+="/front-end"
	NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR"

	neoterm_setup_rust
	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target $CARGO_TARGET_NAME

	local p="$NEOTERM_PKG_CACHEDIR/ytui-music-libmpv-rs-mpv-0.35.0.patch"
	neoterm_download \
		"https://github.com/ParadoxSpiral/libmpv-rs/commit/3e6c389b716f52a595cc5e8e3fa1f96cb76b3de7.patch" \
		"${p}" \
		a7cbd6674191c93ed82c87da7173366b7f56c5998a650b1054de4e4fa3974d69
	echo "Applying $(dirname "${p}")"
	local d
	for d in $CARGO_HOME/registry/src/*/libmpv-sys-*; do
		patch --silent -f -p2 -d ${d} < "${p}" || :
	done
	for d in $CARGO_HOME/registry/src/*/libmpv-[0-9]*; do
		patch --silent -f -p1 -d ${d} < "${p}" || :
	done
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin ../target/${CARGO_TARGET_NAME}/release/ytui_music
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install yt-dlp
	EOF
}
