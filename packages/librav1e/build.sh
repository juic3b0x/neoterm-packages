NEOTERM_PKG_HOMEPAGE=https://github.com/xiph/rav1e/
NEOTERM_PKG_DESCRIPTION="An AV1 encoder library focused on speed and safety"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.1"
NEOTERM_PKG_SRCURL=https://github.com/xiph/rav1e/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=da7ae0df2b608e539de5d443c096e109442cdfa6c5e9b4014361211cf61d030c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_make_install() {
	neoterm_setup_rust
	neoterm_setup_cargo_c

	export CARGO_BUILD_TARGET=$CARGO_TARGET_NAME

	cargo fetch \
		--target $CARGO_TARGET_NAME \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS

	cargo install \
		--jobs $NEOTERM_MAKE_PROCESSES \
		--path . \
		--force \
		--locked \
		--no-track \
		--target $CARGO_TARGET_NAME \
		--root $NEOTERM_PREFIX \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS

	# `cargo cinstall` refuses to work with Android
	cargo cbuild \
		--release \
		--prefix $NEOTERM_PREFIX \
		--jobs $NEOTERM_MAKE_PROCESSES \
		--frozen \
		--target $CARGO_TARGET_NAME \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS

	cd target/$CARGO_TARGET_NAME/release/
	mkdir -p $NEOTERM_PREFIX/include/rav1e/
	cp rav1e.h $NEOTERM_PREFIX/include/rav1e/
	mkdir -p $NEOTERM_PREFIX/lib/pkgconfig/
	cp rav1e.pc $NEOTERM_PREFIX/lib/pkgconfig/
	cp librav1e.a $NEOTERM_PREFIX/lib/
	cp librav1e.so $NEOTERM_PREFIX/lib/librav1e.so.$NEOTERM_PKG_VERSION
	ln -s librav1e.so.$NEOTERM_PKG_VERSION \
		$NEOTERM_PREFIX/lib/librav1e.so.${NEOTERM_PKG_VERSION%%.*}
	ln -s librav1e.so.$NEOTERM_PKG_VERSION $NEOTERM_PREFIX/lib/librav1e.so
}
