NEOTERM_PKG_HOMEPAGE=https://www.ruby-lang.org/
NEOTERM_PKG_DESCRIPTION="Dynamic programming language with a focus on simplicity and productivity"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Packages which should be rebuilt after "minor" bump (e.g. 3.1.x to 3.2.0):
# - asciidoctor
# - weechat
NEOTERM_PKG_VERSION=3.2.2
NEOTERM_PKG_SRCURL=https://cache.ruby-lang.org/pub/ruby/$(echo $NEOTERM_PKG_VERSION | cut -d . -f 1-2)/ruby-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=4b352d0f7ec384e332e3e44cdbfdcd5ff2d594af3c8296b5636c710975149e23
# libbffi is used by the fiddle extension module:
NEOTERM_PKG_DEPENDS="libandroid-execinfo, libandroid-support, libffi, libgmp, readline, openssl, libyaml, zlib"
NEOTERM_PKG_RECOMMENDS="clang, make, pkg-config, resolv-conf"
NEOTERM_PKG_BREAKS="ruby-dev"
NEOTERM_PKG_REPLACES="ruby-dev"
# Needed to fix compilation on android:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setgroups=no ac_cv_func_setresuid=no ac_cv_func_setreuid=no --enable-rubygems"
# Do not link in libcrypt.so if available (now in disabled-packages):
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"
# Fix DEPRECATED_TYPE macro clang compatibility:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" rb_cv_type_deprecated=x"
# getresuid(2) does not work on ChromeOS - https://github.com/neoterm/neoterm-app/issues/147:
# NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_getresuid=no"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--prefix=$NEOTERM_PKG_HOSTBUILD_DIR/ruby-host
--disable-install-doc
--disable-install-rdoc
--disable-install-capi
"

neoterm_step_host_build() {
	"$NEOTERM_PKG_SRCDIR/configure" ${NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j $NEOTERM_MAKE_PROCESSES
	make install
}

neoterm_step_pre_configure() {
	_RUBY_API_VERSION=$(echo $NEOTERM_PKG_VERSION | cut -d . -f 1-2).0
	test ${_RUBY_ABI_VERSION:=} && _RUBY_API_VERSION+=+${_RUBY_ABI_VERSION}

	echo "Applying tool-rbinstall.rb.diff"
	sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
		-e "s|@RUBY_API_VERSION@|${_RUBY_API_VERSION}|g" \
		$NEOTERM_PKG_BUILDER_DIR/tool-rbinstall.rb.diff \
		| patch --silent -p1

	autoreconf -fi

	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR/ruby-host/bin:$PATH

	if [ "$NEOTERM_ARCH_BITS" = 32 ]; then
		# process.c:function timetick2integer: error: undefined reference to '__mulodi4'
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" rb_cv_builtin___builtin_mul_overflow=no"
	fi

	# Do not remove: fix for Clang's "overoptimization".
	CFLAGS+=" -fno-strict-aliasing"
}

neoterm_step_make_install() {
	make install
	make uninstall # remove possible remains to get fresh timestamps
	make install

	local RBCONFIG=$NEOTERM_PREFIX/lib/ruby/${_RUBY_API_VERSION}/${NEOTERM_HOST_PLATFORM}/rbconfig.rb

	# Fix absolute paths to executables:
	perl -p -i -e 's/^.*CONFIG\["INSTALL"\].*$/  CONFIG["INSTALL"] = "install -c"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["PKG_CONFIG"\].*$/  CONFIG["PKG_CONFIG"] = "pkg-config"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["MAKEDIRS"\].*$/  CONFIG["MAKEDIRS"] = "mkdir -p"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["MKDIR_P"\].*$/  CONFIG["MKDIR_P"] = "mkdir -p"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["EGREP"\].*$/  CONFIG["EGREP"] = "grep -E"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["GREP"\].*$/  CONFIG["GREP"] = "grep"/' $RBCONFIG
}

neoterm_step_post_massage() {
	if [ ! -f ./lib/ruby/${_RUBY_API_VERSION}/${NEOTERM_HOST_PLATFORM}/readline.so ]; then
		neoterm_error_exit "The readline extension was not installed."
	fi
	local _RUBYGEMS_ARCH=${NEOTERM_HOST_PLATFORM/i686-/x86-}
	if [ ! -d ./lib/ruby/gems/${_RUBY_API_VERSION}/extensions/${_RUBYGEMS_ARCH} ]; then
		neoterm_error_exit "Extensions for bundled gems were not installed."
	fi
}
