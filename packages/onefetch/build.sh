NEOTERM_PKG_HOMEPAGE=https://github.com/o2sh/onefetch
NEOTERM_PKG_DESCRIPTION="A command-line Git information tool written in Rust"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@ELWAER-M"
NEOTERM_PKG_VERSION="2.19.0"
NEOTERM_PKG_SRCURL=https://github.com/o2sh/onefetch/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e6aa7504730de86f307d6c3671875b11a447a4088daf74df280c8f644dea4819
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libgit2"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust
	neoterm_setup_cmake

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	rm -rf $CARGO_HOME/registry/src/*/cmake-*
	cargo fetch --target "${CARGO_TARGET_NAME}"

	local p="cmake-0.1.50-src-lib.rs.diff"
	local d
	for d in $CARGO_HOME/registry/src/*/cmake-*; do
		patch --silent -p1 -d ${d} \
			< "$NEOTERM_PKG_BUILDER_DIR/${p}"
	done

	local f
	for f in $CARGO_HOME/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build \
		--jobs $NEOTERM_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME \
		--release
}
	
neoterm_step_make_install() {
	install -Dm700 target/"${CARGO_TARGET_NAME}"/release/onefetch "$NEOTERM_PREFIX"/bin

	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/bash-completion/completions/onefetch.bash
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/zsh/site-functions/_onefetch
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/fish/vendor_completions.d/onefetch.fish
}

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		onefetch --generate bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/onefetch.bash
		onefetch --generate zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_onefetch
		onefetch --generate fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/onefetch.fish
	EOF
}
