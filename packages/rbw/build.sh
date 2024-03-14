NEOTERM_PKG_HOMEPAGE=https://github.com/doy/rbw
NEOTERM_PKG_DESCRIPTION="An unofficial command line client for Bitwarden"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.9.0"
NEOTERM_PKG_SRCURL=https://github.com/doy/rbw/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fdf2942b3b9717e5923ac9b8f2b2cece0c1e47713292ea501af9709398efbacd
NEOTERM_PKG_DEPENDS="pinentry"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin $NEOTERM_PKG_SRCDIR/target/${CARGO_TARGET_NAME}/release/rbw
	install -Dm755 -t $NEOTERM_PREFIX/bin $NEOTERM_PKG_SRCDIR/target/${CARGO_TARGET_NAME}/release/rbw-agent

	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/bash-completion/completions/rbw.bash"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/zsh/site-functions/_rbw"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/fish/vendor_completions.d/rbw.fish"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/elvish/lib/rbw.elv"
}

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		rbw gen-completions bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/rbw.bash
		rbw gen-completions zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_rbw
		rbw gen-completions fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/rbw.fish
		rbw gen-completions elvish > ${NEOTERM_PREFIX}/share/elvish/lib/rbw.elv
	EOF
}
