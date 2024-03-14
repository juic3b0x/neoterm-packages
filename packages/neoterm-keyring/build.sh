NEOTERM_PKG_HOMEPAGE=https://github.com/neoterm
NEOTERM_PKG_DESCRIPTION="GPG public keys for the official Termux repositories"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.11
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_ESSENTIAL=true

neoterm_step_make_install() {
	local GPG_SHARE_DIR="$NEOTERM_PREFIX/share/neoterm-keyring"

	mkdir -p $GPG_SHARE_DIR

	# Maintainer-specific keys.
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/agnostic-apollo.gpg $GPG_SHARE_DIR
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/grimler.gpg $GPG_SHARE_DIR
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/kcubeterm.gpg $GPG_SHARE_DIR
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/landfillbaby.gpg $GPG_SHARE_DIR
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/mradityaalok.gpg $GPG_SHARE_DIR
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/2096779623.gpg $GPG_SHARE_DIR

	# Key for automatic builds (via CI).
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/neoterm-autobuilds.gpg $GPG_SHARE_DIR

	# Key for pacman package manager.
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/neoterm-pacman.gpg $GPG_SHARE_DIR

	for GPG_DIR in "$NEOTERM_PREFIX/etc/apt/trusted.gpg.d" "$NEOTERM_PREFIX/share/pacman/keyrings"; do
		mkdir -p $GPG_DIR
		for GPG_FILE in $GPG_SHARE_DIR/*.gpg; do
			if [[ "$GPG_DIR" == *"/apt/"* && "$GPG_FILE" == *"neoterm-pacman.gpg"* ]]; then
				continue
			fi
			ln -s "$GPG_FILE" "$GPG_DIR/$(basename $GPG_FILE)"
		done
		# Creation of trusted files
		if [[ "$GPG_DIR" == *"/pacman/"* ]]; then
			echo "998DE27318E867EA976BA877389CEED64573DFCA:4:" > $GPG_DIR/neoterm-pacman-trusted
		fi
	done
}

neoterm_step_create_debscripts() {
	if [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ]; then
		echo "if [ ! -d $NEOTERM_PREFIX/etc/pacman.d/ ]; then" > postupg
		echo "  pacman-key --init" >> postupg
		echo "fi" >> postupg
		echo "pacman-key --populate" >> postupg
		echo "post_upgrade" > postinst
	fi
}
