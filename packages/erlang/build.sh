NEOTERM_PKG_HOMEPAGE=https://www.erlang.org/
NEOTERM_PKG_DESCRIPTION="General-purpose concurrent functional programming language"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="26.2.3"
NEOTERM_PKG_SRCURL=https://github.com/erlang/otp/archive/OTP-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=7a79e7955890b06572dbb3c3460771a71f729c15bc6ced018916a432669fd239
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP='\d+(\.\d+)+'
NEOTERM_PKG_DEPENDS="libc++, openssl, ncurses, zlib"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-javac
--with-ssl=${NEOTERM_PREFIX}
--with-termcap
erl_xcomp_sysroot=${NEOTERM_PREFIX}
"
neoterm_pkg_auto_update() {
	# Get latest release tag:
	local tag
	tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	# check if this is not an intermediate release candidate:
	if grep -qP "^OTP-${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not stable release($tag)"
	fi
}

neoterm_step_post_get_source() {
	# We need a host build every time, because we dont know the full output of host build and have no idea to cache it.
	rm -Rf "$NEOTERM_PKG_HOSTBUILD_DIR"
}

neoterm_step_host_build() {
	cd $NEOTERM_PKG_BUILDDIR
	# Erlang cross compile reference: https://github.com/erlang/otp/blob/master/HOWTO/INSTALL-CROSS.md#building-a-bootstrap-system
	# Build erlang bootstrap system.
	./configure --enable-bootstrap-only --without-javac --without-ssl --without-termcap
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_pre_configure() {
	# Add --build flag for erlang cross build
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --build=$(./erts/autoconf/config.guess)"

	# Use a wrapper CC to move `-I@NEOTERM_PREFIX@/include` to the last include param
	mkdir -p $NEOTERM_PKG_TMPDIR/_fake_bin
	sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
		-e "s|@COMPILER@|$(command -v ${CC})|g" \
		"$NEOTERM_PKG_BUILDER_DIR"/wrapper.py.in \
		> $NEOTERM_PKG_TMPDIR/_fake_bin/"$(basename ${CC})"
	chmod +x $NEOTERM_PKG_TMPDIR/_fake_bin/"$(basename ${CC})"
	export PATH="$NEOTERM_PKG_TMPDIR/_fake_bin:$PATH"
}
