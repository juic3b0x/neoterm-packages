neoterm_step_override_config_scripts() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" = true ]; then
		return
	fi

	# Make $NEOTERM_PREFIX/bin/sh executable on the builder, so that build
	# scripts can assume that it works on both builder and host later on:
	ln -sf /bin/sh "$NEOTERM_PREFIX/bin/sh"

	if [ "$NEOTERM_INSTALL_DEPS" = false ]; then
		return
	fi

	if [ "$NEOTERM_PKG_DEPENDS" != "${NEOTERM_PKG_DEPENDS/libllvm/}" ]; then
		LLVM_DEFAULT_TARGET_TRIPLE=$NEOTERM_HOST_PLATFORM
		if [ $NEOTERM_ARCH = "arm" ]; then
			LLVM_TARGET_ARCH=ARM
		elif [ $NEOTERM_ARCH = "aarch64" ]; then
			LLVM_TARGET_ARCH=AArch64
		elif [ $NEOTERM_ARCH = "i686" ]; then
			LLVM_TARGET_ARCH=X86
		elif [ $NEOTERM_ARCH = "x86_64" ]; then
			LLVM_TARGET_ARCH=X86
		fi
		LIBLLVM_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/libllvm/build.sh; echo $NEOTERM_PKG_VERSION)
		sed $NEOTERM_SCRIPTDIR/packages/libllvm/llvm-config.in \
			-e "s|@NEOTERM_PKG_VERSION@|$LIBLLVM_VERSION|g" \
			-e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" \
			-e "s|@LLVM_TARGET_ARCH@|$LLVM_TARGET_ARCH|g" \
			-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_DEFAULT_TARGET_TRIPLE|g" \
			-e "s|@NEOTERM_ARCH@|$NEOTERM_ARCH|g" > $NEOTERM_PREFIX/bin/llvm-config
		chmod 755 $NEOTERM_PREFIX/bin/llvm-config
	fi

	if [ "$NEOTERM_PKG_DEPENDS" != "${NEOTERM_PKG_DEPENDS/postgresql/}" ]; then
		local postgresql_version=$(. $NEOTERM_SCRIPTDIR/packages/postgresql/build.sh; echo $NEOTERM_PKG_VERSION)
		sed $NEOTERM_SCRIPTDIR/packages/postgresql/pg_config.in \
			-e "s|@POSTGRESQL_VERSION@|$postgresql_version|g" \
			-e "s|@NEOTERM_HOST_PLATFORM@|$NEOTERM_HOST_PLATFORM|g" \
			-e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" > $NEOTERM_PREFIX/bin/pg_config
		chmod 755 $NEOTERM_PREFIX/bin/pg_config
	fi
}
