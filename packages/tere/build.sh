NEOTERM_PKG_HOMEPAGE=https://github.com/mgunyho/tere
NEOTERM_PKG_DESCRIPTION="Terminal file explorer written in rust"
NEOTERM_PKG_LICENSE="EUPL-1.2"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.5.1"
NEOTERM_PKG_SRCURL=https://github.com/mgunyho/tere/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d7f657371ffbd469c4d8855c2a2734c20b53ae632fe3cbf9bb7cab94bd726326
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_rust

	export CFLAGS="${TARGET_CFLAGS}"

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	rm -rf $CARGO_HOME/registry/src/*/rustix-*
	cargo fetch --target "${CARGO_TARGET_NAME}"

	for d in $CARGO_HOME/registry/src/*/rustix-*; do
		patch --silent -p1 -d ${d} < $NEOTERM_PKG_BUILDER_DIR/0001-rustix-fix-libc-removing-unsafe-on-makedev.diff || :
	done
}

neoterm_step_make() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/tere
}
