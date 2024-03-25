NEOTERM_PKG_HOMEPAGE=https://github.com/denoland/rusty_v8
NEOTERM_PKG_DESCRIPTION="High quality Rust bindings to V8's C++ API"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=8b90dfd2f4fcbbaefd2c4d2be220d94a00a3ebba
NEOTERM_PKG_VERSION=2022.02.02
NEOTERM_PKG_SRCURL=git+https://github.com/denoland/rusty_v8
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

neoterm_step_post_get_source() {
	git fetch --unshallow || true
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	git submodule update --init --recursive
}

neoterm_step_pre_configure() {
	export V8_FROM_SOURCE=1
	export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig
}

neoterm_step_make() {
	neoterm_setup_rust
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/lib \
		target/$CARGO_TARGET_NAME/release/gn_out/obj/librusty_v8.a
}

neoterm_step_post_make_install() {
	unset V8_FROM_SOURCE
	unset PKG_CONFIG_PATH
}
