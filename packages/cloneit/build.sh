NEOTERM_PKG_HOMEPAGE=https://github.com/alok8bb/cloneit
NEOTERM_PKG_DESCRIPTION="A cli tool to download specific GitHub directories or files"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=62c433f0b1c54a977d585f3b84b8c43213095474
_COMMIT_DATE=2022.10.24
NEOTERM_PKG_VERSION=${_COMMIT_DATE//./}
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/alok8bb/cloneit
NEOTERM_PKG_SHA256=61b2631109817bd468d5b8ab6411206fff75df13bafb45e53558139eea46c0cb
NEOTERM_PKG_GIT_BRANCH="master"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="openssl-1.1"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_pre_configure() {
	# openssl-sys supports OpenSSL 3 in >= 0.9.69
	export OPENSSL_INCLUDE_DIR=$NEOTERM_PREFIX/include/openssl-1.1
	export OPENSSL_LIB_DIR=$NEOTERM_PREFIX/lib/openssl-1.1
	CFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CFLAGS"
	CPPFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CPPFLAGS"
	CXXFLAGS="-I$NEOTERM_PREFIX/include/openssl-1.1 $CXXFLAGS"
	LDFLAGS="-L$NEOTERM_PREFIX/lib/openssl-1.1 -Wl,-rpath=$NEOTERM_PREFIX/lib/openssl-1.1 $LDFLAGS"
	RUSTFLAGS+=" -C link-arg=-Wl,-rpath=$NEOTERM_PREFIX/lib/openssl-1.1"
}

neoterm_step_make() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/cloneit
}
