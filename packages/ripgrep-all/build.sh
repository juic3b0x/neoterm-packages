NEOTERM_PKG_HOMEPAGE=https://github.com/phiresky/ripgrep-all
NEOTERM_PKG_DESCRIPTION="Search tool able to locate in PDFs, E-Books, zip, tar.gz, etc"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="1.0.0-alpha.5"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_DEPENDS="ripgrep, fzf"
NEOTERM_PKG_RECOMMENDS="ffmpeg, poppler, sqlite"
NEOTERM_PKG_SRCURL=https://github.com/phiresky/ripgrep-all/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bda5944e3fdfba4348b1b27b3ab770c5daf5a62feff86a1dcaa4221f450c7f19
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_rust

	RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rga
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rga-preproc
	install -m755 $NEOTERM_PKG_BUILDER_DIR/rga-fzf  $NEOTERM_PREFIX/bin/rga-fzf
}
