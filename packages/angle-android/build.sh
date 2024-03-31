NEOTERM_PKG_HOMEPAGE=https://chromium.googlesource.com/angle/angle
NEOTERM_PKG_DESCRIPTION="A conformant OpenGL ES implementation for Windows, Mac, Linux, iOS and Android"
NEOTERM_PKG_LICENSE="BSD 3-Clause, Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT_DATE=2023.7.11
_COMMIT=75e647193aeb1a78dad27bd5dc8f0199262800d1
_COMMIT_POSISION=21474
NEOTERM_PKG_SRCURL=git+https://chromium.googlesource.com/angle/angle
NEOTERM_PKG_VERSION="2.1.$_COMMIT_POSISION-${_COMMIT:0:8}"

NEOTERM_PKG_HOSTBUILD=true

neoterm_step_get_source() {
	# Check whether we need to get source
	if [ -f "$NEOTERM_PKG_CACHEDIR/.angle-source-fetched" ]; then
		local _fetched_source_version=$(cat $NEOTERM_PKG_CACHEDIR/.angle-source-fetched)
		if [ "$_fetched_source_version" = "$NEOTERM_PKG_VERSION" ]; then
			echo "[INFO]: Use pre-fetched source (version $_fetched_source_version)."
			ln -sfr $NEOTERM_PKG_CACHEDIR/tmp-checkout/angle $NEOTERM_PKG_SRCDIR
			return
		fi
	fi

	# Fetch depot_tools
	if [ ! -f "$NEOTERM_PKG_CACHEDIR/.depot_tools-fetched" ];then
		git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git $NEOTERM_PKG_CACHEDIR/depot_tools
		touch "$NEOTERM_PKG_CACHEDIR/.depot_tools-fetched"
	fi
	export PATH="$NEOTERM_PKG_CACHEDIR/depot_tools:$PATH"
	export DEPOT_TOOLS_UPDATE=0

	# Get source
	rm -rf "$NEOTERM_PKG_CACHEDIR/tmp-checkout"
	mkdir -p "$NEOTERM_PKG_CACHEDIR/tmp-checkout"
	pushd "$NEOTERM_PKG_CACHEDIR/tmp-checkout"
	gclient config --verbose --unmanaged ${NEOTERM_PKG_SRCURL#git+}
	echo "" >> .gclient
	echo 'target_os = ["android"]' >> .gclient
	gclient sync --verbose --revision $_COMMIT

	# Check commit posision
	cd angle
	local _real_commit_posision="$(git rev-list HEAD --count)"
	if [ "$_real_commit_posision" != "$_COMMIT_POSISION" ]; then
		neoterm_error_exit "Please update commit posision. Expected: $_COMMIT_POSISION, current: $_real_commit_posision."
	fi
	popd

	echo "$NEOTERM_PKG_VERSION" > "$NEOTERM_PKG_CACHEDIR/.angle-source-fetched"
	ln -sfr $NEOTERM_PKG_CACHEDIR/tmp-checkout/angle $NEOTERM_PKG_SRCDIR
}

neoterm_step_host_build() {
	cd $NEOTERM_PKG_HOSTBUILD_DIR

	neoterm_setup_ninja
	export PATH="$NEOTERM_PKG_CACHEDIR/depot_tools:$PATH"
	export DEPOT_TOOLS_UPDATE=0

	local _target_os=
	if [ "$NEOTERM_ARCH" = "aarch64" ] || [ "$NEOTERM_ARCH" = "arm" ]; then
		_target_os="arm64"
	elif [ "$NEOTERM_ARCH" = "x86_64" ] || [ "$NEOTERM_ARCH" = "i686" ]; then
		_target_os="x64"
	else
		neoterm_error_exit "Unsupported arch: $NEOTERM_ARCH"
	fi

	# Build with Android's GL
	mkdir -p out/android
	sed -e"s|@TARGET_OS@|$_target_os|g" \
		-e "s|@ENABLE_GL@|true|g" \
		-e "s|@ENABLE_VULKAN@|false|g" \
		-e "s|@USE_VULKAN_NULL@|false|g" \
		-e "s|@NEOTERM_PKG_API_LEVEL@|$NEOTERM_PKG_API_LEVEL|g" \
		$NEOTERM_PKG_BUILDER_DIR/args.gn.in > out/android/args.gn
	pushd $NEOTERM_PKG_SRCDIR
	gn gen $NEOTERM_PKG_HOSTBUILD_DIR/out/android --export-compile-commands
	popd
	ninja -C out/android
	mkdir -p build/gl
	cp out/android/apks/AngleLibraries.apk build/gl/
	pushd build/gl
	unzip AngleLibraries.apk
	popd

	# Build with Android's Vulkan
	mkdir -p out/android
	sed -e"s|@TARGET_OS@|$_target_os|g" \
		-e "s|@ENABLE_GL@|false|g" \
		-e "s|@ENABLE_VULKAN@|true|g" \
		-e "s|@USE_VULKAN_NULL@|false|g" \
		-e "s|@NEOTERM_PKG_API_LEVEL@|$NEOTERM_PKG_API_LEVEL|g" \
		$NEOTERM_PKG_BUILDER_DIR/args.gn.in > out/android/args.gn
	pushd $NEOTERM_PKG_SRCDIR
	gn gen $NEOTERM_PKG_HOSTBUILD_DIR/out/android --export-compile-commands
	popd
	ninja -C out/android
	mkdir -p build/vulkan
	cp out/android/apks/AngleLibraries.apk build/vulkan/
	pushd build/vulkan
	unzip AngleLibraries.apk
	popd

	# Build with Android's Vulkan null display
	mkdir -p out/android
	sed -e "s|@TARGET_OS@|$_target_os|g" \
		-e "s|@ENABLE_GL@|false|g" \
		-e "s|@ENABLE_VULKAN@|true|g" \
		-e "s|@USE_VULKAN_NULL@|true|g" \
		-e "s|@NEOTERM_PKG_API_LEVEL@|$NEOTERM_PKG_API_LEVEL|g" \
		$NEOTERM_PKG_BUILDER_DIR/args.gn.in > out/android/args.gn
	pushd $NEOTERM_PKG_SRCDIR
	gn gen $NEOTERM_PKG_HOSTBUILD_DIR/out/android --export-compile-commands
	popd
	ninja -C out/android
	mkdir -p build/vulkan-null
	cp out/android/apks/AngleLibraries.apk build/vulkan-null/
	pushd build/vulkan-null
	unzip AngleLibraries.apk
	popd
}

neoterm_step_configure() {
	# Remove this marker all the time, as this package is architecture-specific
	rm -rf $NEOTERM_HOSTBUILD_MARKER
}

neoterm_step_configure() {
	:
}

neoterm_step_make() {
	:
}

neoterm_step_make_install() {
	local _lib_dir=
	if [ "$NEOTERM_ARCH" = "arm" ]; then
		_lib_dir="armeabi-v7a"
	elif [ "$NEOTERM_ARCH" = "i686" ]; then
		_lib_dir="x86"
	elif [ "$NEOTERM_ARCH" = "x86_64" ]; then
		_lib_dir="x86_64"
	elif [ "$NEOTERM_ARCH" = "aarch64" ]; then
		_lib_dir="arm64-v8a"
	else
		neoterm_error_exit "Unsupported arch: $NEOTERM_ARCH"
	fi

	local _type
	for _type in gl vulkan vulkan-null; do
		mkdir -p $NEOTERM_PREFIX/opt/angle-android/$_type
		cp -v $NEOTERM_PKG_HOSTBUILD_DIR/build/$_type/lib/$_lib_dir/*.so $NEOTERM_PREFIX/opt/angle-android/$_type/
	done
}
