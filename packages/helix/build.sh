NEOTERM_PKG_HOMEPAGE="https://helix-editor.com/"
NEOTERM_PKG_DESCRIPTION="A post-modern modal text editor written in rust"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="Aditya Alok <alok@neoterm.org>"
NEOTERM_PKG_VERSION="23.10"
NEOTERM_PKG_SRCURL="git+https://github.com/helix-editor/helix"
NEOTERM_PKG_GIT_BRANCH="${NEOTERM_PKG_VERSION}"
NEOTERM_PKG_SUGGESTS="helix-grammars"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_RM_AFTER_INSTALL="
opt/helix/runtime/grammars/sources/
"

neoterm_step_make_install() {
	neoterm_setup_rust

	cargo build --jobs "${NEOTERM_MAKE_PROCESSES}" --target "${CARGO_TARGET_NAME}" --release

	local datadir="${NEOTERM_PREFIX}/opt/${NEOTERM_PKG_NAME}"
	mkdir -p "${datadir}"

	cat >"${NEOTERM_PREFIX}/bin/hx" <<-EOF
		#!${NEOTERM_PREFIX}/bin/sh
		HELIX_RUNTIME=${datadir}/runtime exec ${datadir}/hx "\$@"
	EOF
	chmod 0700 "${NEOTERM_PREFIX}/bin/hx"

	install -Dm700 target/"${CARGO_TARGET_NAME}"/release/hx "${datadir}/hx"

	cp -r ./runtime "${datadir}"
	find "${datadir}"/runtime/grammars -type f -name "*.so" -exec chmod 0700 {} \;
}
