NEOTERM_PKG_HOMEPAGE=https://starship.rs
NEOTERM_PKG_DESCRIPTION="A minimal, blazing fast, and extremely customizable prompt for any shell"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.17.1
NEOTERM_PKG_SRCURL=https://github.com/starship/starship/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2b2fc84feb0197104982e8baf17952449375917da66b7a98b3e3fd0be63e5dba
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_DEPENDS="zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--all-features"
NEOTERM_PKG_SUGGESTS="nerdfix"

neoterm_step_pre_configure() {
	neoterm_setup_rust
	neoterm_setup_cmake
	: "${CARGO_HOME:=${HOME}/.cargo}"
	export CARGO_HOME

	rm -rf $CARGO_HOME/registry/src/*/cmake-*
	rm -rf $CARGO_HOME/registry/src/*/gix-index-*
	cargo fetch --target "${CARGO_TARGET_NAME}"

	local p="cmake-0.1.50-src-lib.rs.diff"
	local d
	for d in $CARGO_HOME/registry/src/*/cmake-*; do
		patch --silent -p1 -d ${d} \
			< "$NEOTERM_PKG_BUILDER_DIR/${p}"
	done

	mv "${NEOTERM_PREFIX}"/lib/libz.so.1{,.tmp}
	mv "${NEOTERM_PREFIX}"/lib/libz.so{,.tmp}

	local _CARGO_TARGET_LIBDIR="target/${CARGO_TARGET_NAME}/release/deps"
	mkdir -p "${_CARGO_TARGET_LIBDIR}"

	ln -sfT "$(readlink -f "${NEOTERM_PREFIX}"/lib/libz.so.1.tmp)" \
		"${_CARGO_TARGET_LIBDIR}"/libz.so.1
	ln -sfT "$(readlink -f "${NEOTERM_PREFIX}"/lib/libz.so.tmp)" \
		"${_CARGO_TARGET_LIBDIR}"/libz.so

	RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
}

neoterm_step_post_make_install() {
	mv "${NEOTERM_PREFIX}"/lib/libz.so.1{.tmp,}
	mv "${NEOTERM_PREFIX}"/lib/libz.so{.tmp,}

	# Make a placeholder for shell-completions (to be filled with postinst)
	mkdir -p ${NEOTERM_PREFIX}/share/bash-completions/completions
	mkdir -p ${NEOTERM_PREFIX}/share/fish/vendor_completions.d
	mkdir -p ${NEOTERM_PREFIX}/share/zsh/site-functions
	touch ${NEOTERM_PREFIX}/share/bash-completions/completions/starship
	touch ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/starship.fish
	touch ${NEOTERM_PREFIX}/share/zsh/site-functions/_starship
}

neoterm_step_post_massage() {
	rm -f lib/libz.so.1
	rm -f lib/libz.so
}

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${NEOTERM_PREFIX}/bin/sh

		starship completions bash > ${NEOTERM_PREFIX}/share/bash-completions/completions/starship
		starship completions fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/starship.fish
		starship completions zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_starship
	EOF
}
