NEOTERM_PKG_HOMEPAGE=https://github.com/chipsenkbeil/distant
NEOTERM_PKG_DESCRIPTION="Library and tooling that supports remote filesystem and process"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:0.20.0"
NEOTERM_PKG_SRCURL=https://github.com/chipsenkbeil/distant/archive/refs/tags/v${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=28044639adb3a7984a1c2e721debbaa472e6d826795c5d2f7c434c563e261007
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libssh2, openssl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export OPENSSL_NO_VENDOR=1
	export OPENSSL_INCLUDE_DIR=$NEOTERM_PREFIX/include/openssl
	export OPENSSL_LIB_DIR=$NEOTERM_PREFIX/lib
	export LIBSSH2_SYS_USE_PKG_CONFIG=1
	export PKG_CONFIG_ALLOW_CROSS=1

    sed -i "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" ${NEOTERM_PKG_SRCDIR}/src/constants.rs

	neoterm_setup_rust
	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target $CARGO_TARGET_NAME

	local d
	local p=termios-0.2.2.diff
	for d in $CARGO_HOME/registry/src/*/termios-0.2.2; do
		patch --silent -p1 -d ${d} \
			< "$NEOTERM_PKG_BUILDER_DIR/${p}" || :
	done
	p=service-manager-0.2.0.diff
	for d in $CARGO_HOME/registry/src/*/service-manager-*; do
		patch --silent -p1 -d ${d} \
			< "$NEOTERM_PKG_BUILDER_DIR/${p}" || :
	done
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/distant
}

neoterm_step_post_massage() {
	mkdir -p ./share/bash-completion/completions
	mkdir -p ./share/zsh/site-functions
	mkdir -p ./share/fish/vendor_completions.d
}

neoterm_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		${NEOTERM_PREFIX}/bin/distant generate completion bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/distant
		${NEOTERM_PREFIX}/bin/distant generate completion zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_distant
		${NEOTERM_PREFIX}/bin/distant generate completion fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/distant.fish
		exit 0
	EOF
	cat <<-EOF > ./prerm
		#!${NEOTERM_PREFIX}/bin/sh
		rm -f ${NEOTERM_PREFIX}/share/bash-completion/completions/distant
		rm -f ${NEOTERM_PREFIX}/share/zsh/site-functions/_distant
		rm -f ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/distant.fish
		exit 0
	EOF
}
