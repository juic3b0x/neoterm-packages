NEOTERM_PKG_HOMEPAGE=https://tmux.github.io/
NEOTERM_PKG_DESCRIPTION="Terminal multiplexer"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=fbe6fe7f55cfc2a32f9cee4cb50502a53d3ce8bb
_COMMIT_DATE=20230428
NEOTERM_PKG_VERSION=3.3a-p${_COMMIT_DATE}
NEOTERM_PKG_SRCURL=git+https://github.com/tmux/tmux
NEOTERM_PKG_SHA256=b61189533139bb84bdc0e96546a5420c183d7ba946a559e891d313c1c32d953d
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_AUTO_UPDATE=false
# Link against libandroid-support for wcwidth(), see https://github.com/juic3b0x/neoterm-packages/issues/224
NEOTERM_PKG_DEPENDS="ncurses, libevent, libandroid-support, libandroid-glob"
# Set default TERM to screen-256color, see: https://raw.githubusercontent.com/tmux/tmux/3.3/CHANGES
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-static --with-TERM=screen-256color"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_CONFFILES="etc/tmux.conf etc/profile.d/tmux.sh"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local pdate="p$(git log -1 --format=%cs | sed 's/-//g')"
	if [[ "$NEOTERM_PKG_VERSION" != *"${pdate}" ]]; then
		echo -n "ERROR: The version string \"$NEOTERM_PKG_VERSION\" is"
		echo -n " different from what is expected to be; should end"
		echo " with \"${pdate}\"."
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	./autogen.sh
}

neoterm_step_post_make_install() {
	cp "$NEOTERM_PKG_BUILDER_DIR"/tmux.conf "$NEOTERM_PREFIX"/etc/tmux.conf

	mkdir -p "$NEOTERM_PREFIX"/etc/profile.d
	echo "export TMUX_TMPDIR=$NEOTERM_PREFIX/var/run" > "$NEOTERM_PREFIX"/etc/profile.d/tmux.sh

	mkdir -p "$NEOTERM_PREFIX"/share/bash-completion/completions
	neoterm_download \
		https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/homebrew_1.0.0/completions/tmux \
		"$NEOTERM_PREFIX"/share/bash-completion/completions/tmux \
		05e79fc1ecb27637dc9d6a52c315b8f207cf010cdcee9928805525076c9020ae
}

neoterm_step_post_massage() {
	mkdir -p "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}"/var/run
}
