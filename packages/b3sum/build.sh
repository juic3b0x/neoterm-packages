NEOTERM_PKG_HOMEPAGE=https://github.com/BLAKE3-team/BLAKE3/tree/master/b3sum
NEOTERM_PKG_DESCRIPTION="A command line utility for calculating BLAKE3 hashes, similar to Coreutils tools like b2sum or md5sum"
NEOTERM_PKG_LICENSE="CC0-1.0"
NEOTERM_PKG_MAINTAINER="@medzikuser"
NEOTERM_PKG_VERSION="1.5.1"
NEOTERM_PKG_SRCURL=https://github.com/BLAKE3-team/BLAKE3/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=822cd37f70152e5985433d2c50c8f6b2ec83aaf11aa31be9fe71486a91744f37
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_rust

	cd $NEOTERM_PKG_SRCDIR/b3sum

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin $NEOTERM_PKG_SRCDIR/b3sum/target/${CARGO_TARGET_NAME}/release/b3sum
}
