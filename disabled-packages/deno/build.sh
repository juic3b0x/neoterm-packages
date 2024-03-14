NEOTERM_PKG_HOMEPAGE=https://deno.land/
NEOTERM_PKG_DESCRIPTION="A modern runtime for JavaScript and TypeScript"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=1259a3f48c00e95a8bb0964e4dabfa769a20bcde
_COMMIT_DATE=2022.01.19
NEOTERM_PKG_VERSION=1.17.3p${_COMMIT_DATE//./}
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=git+https://github.com/denoland/deno
NEOTERM_PKG_GIT_BRANCH=main
NEOTERM_PKG_DEPENDS="libffi"
#NEOTERM_PKG_BUILD_DEPENDS="librusty-v8"
NEOTERM_PKG_BUILD_IN_SRC=true

# Due to dependency on librusty-v8.
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	git submodule update --init --recursive
}

neoterm_step_pre_configure() {
	neoterm_setup_rust

	if [ "$NEOTERM_DEBUG_BUILD" = "true" ]; then
		BUILD_TYPE=debug
	else
		BUILD_TYPE=release
	fi
}

neoterm_step_make() {
	local libdir=target/$CARGO_TARGET_NAME/$BUILD_TYPE/deps
	mkdir -p $libdir
	ln -sf $NEOTERM_PREFIX/lib/libffi.so $libdir/
	local libgcc="$($CC -print-libgcc-file-name)"
	echo "INPUT($libgcc -l:libunwind.a)" > $libdir/libgcc.so
	local cmd="cargo build --jobs $NEOTERM_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME"
	if [ "$NEOTERM_DEBUG_BUILD" = "false" ]; then
		cmd+=" --release"
	fi
	#$cmd || :
	#ln -sf $NEOTERM_PREFIX/lib/librusty_v8.a \
	#	target/$CARGO_TARGET_NAME/release/gn_out/obj/librusty_v8.a
	$cmd
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/$BUILD_TYPE/deno
}
