NEOTERM_PKG_HOMEPAGE=https://github.com/cswinter/LocustDB
NEOTERM_PKG_DESCRIPTION="An experimental analytics database"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.3.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/cswinter/LocustDB/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b4ac9e44edc541522b7663ebbb6dfeafaf58a1a4fd060e86af59ed3baec6574a
NEOTERM_PKG_BUILD_IN_SRC=true

# ```
# error: this arithmetic operation will overflow
#    --> src/locustdb.rs:189:36
#     |
# 189 |             mem_size_limit_tables: 8 * 1024 * 1024 * 1024, // 8 GiB
#     |                                    ^^^^^^^^^^^^^^^^^^^^^^ attempt to multiply with overflow
#     |
#     = note: `#[deny(arithmetic_overflow)]` on by default
# ```
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_make() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -T target/${CARGO_TARGET_NAME}/release/repl $NEOTERM_PREFIX/bin/locustdb
}
