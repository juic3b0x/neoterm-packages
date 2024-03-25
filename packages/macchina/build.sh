NEOTERM_PKG_HOMEPAGE=https://github.com/Macchina-CLI/macchina
NEOTERM_PKG_DESCRIPTION="A system information fetcher, with an emphasis on performance and minimalism."
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Max Ferrer @PandaFoss"
NEOTERM_PKG_VERSION="6.1.8"
NEOTERM_PKG_SRCURL=https://github.com/Macchina-CLI/macchina/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e827f640b55fe47a6127dd0c276e76b597e3cb83916be37351cdd6a81d75311e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_make_install() {
	neoterm_setup_rust
	
	cargo build --jobs ${NEOTERM_MAKE_PROCESSES} --target ${CARGO_TARGET_NAME} --release
	install -Dm755 -t ${NEOTERM_PREFIX}/bin target/${CARGO_TARGET_NAME}/release/macchina
}
