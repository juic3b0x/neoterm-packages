neoterm_setup_toolchain_23c() {
	export CFLAGS=""
	export CPPFLAGS=""
	export LDFLAGS="-L${NEOTERM_PREFIX}/lib"

	export AS=$NEOTERM_HOST_PLATFORM-clang
	export CC=$NEOTERM_HOST_PLATFORM-clang
	export CXX=$NEOTERM_HOST_PLATFORM-clang++
	export CPP=$NEOTERM_HOST_PLATFORM-cpp
	export LD=ld.lld
	export AR=llvm-ar
	export OBJCOPY=llvm-objcopy
	export OBJDUMP=llvm-objdump
	export RANLIB=llvm-ranlib
	export READELF=llvm-readelf
	export STRIP=llvm-strip
	export NM=llvm-nm

	export NEOTERM_HASKELL_OPTIMISATION="-O"
	if [ "${NEOTERM_DEBUG_BUILD}" = true ]; then
		NEOTERM_HASKELL_OPTIMISATION="-O0"
	fi

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		export PATH=$NEOTERM_STANDALONE_TOOLCHAIN/bin:$PATH
		export CC_FOR_BUILD=gcc
		export PKG_CONFIG=$NEOTERM_STANDALONE_TOOLCHAIN/bin/pkg-config
		export PKGCONFIG=$PKG_CONFIG
		export CCNEOTERM_HOST_PLATFORM=$NEOTERM_HOST_PLATFORM$NEOTERM_PKG_API_LEVEL
		if [ $NEOTERM_ARCH = arm ]; then
			CCNEOTERM_HOST_PLATFORM=armv7a-linux-androideabi$NEOTERM_PKG_API_LEVEL
		fi
		LDFLAGS+=" -Wl,-rpath=$NEOTERM_PREFIX/lib"
	else
		export CC_FOR_BUILD=$CC
		# Some build scripts use environment variable 'PKG_CONFIG', so
		# using this for on-device builds too.
		export PKG_CONFIG=pkg-config
	fi
	export PKG_CONFIG_LIBDIR="$NEOTERM_PKG_CONFIG_LIBDIR"

	if [ "$NEOTERM_ARCH" = "arm" ]; then
		# https://developer.android.com/ndk/guides/standalone_toolchain.html#abi_compatibility:
		# "We recommend using the -mthumb compiler flag to force the generation of 16-bit Thumb-2 instructions".
		# With r13 of the ndk ruby 2.4.0 segfaults when built on arm with clang without -mthumb.
		CFLAGS+=" -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb"
		LDFLAGS+=" -march=armv7-a"
		export GOARCH=arm
		export GOARM=7
	elif [ "$NEOTERM_ARCH" = "i686" ]; then
		# From $NDK/docs/CPU-ARCH-ABIS.html:
		CFLAGS+=" -march=i686 -msse3 -mstackrealign -mfpmath=sse"
		# i686 seem to explicitly require -fPIC, see
		# https://github.com/juic3b0x/neoterm-packages/issues/7215#issuecomment-906154438
		CFLAGS+=" -fPIC"
		export GOARCH=386
		export GO386=sse2
	elif [ "$NEOTERM_ARCH" = "aarch64" ]; then
		export GOARCH=arm64
	elif [ "$NEOTERM_ARCH" = "x86_64" ]; then
		export GOARCH=amd64
	else
		neoterm_error_exit "Invalid arch '$NEOTERM_ARCH' - support arches are 'arm', 'i686', 'aarch64', 'x86_64'"
	fi

	# -static-openmp requires -fopenmp in LDFLAGS to work; hopefully this won't be problematic
	# even when we don't have -fopenmp in CFLAGS / when we don't want to enable OpenMP
	# We might also want to consider shipping libomp.so instead; since r21
	LDFLAGS+=" -fopenmp -static-openmp"

	# Android 7 started to support DT_RUNPATH (but not DT_RPATH).
	LDFLAGS+=" -Wl,--enable-new-dtags"

	# Avoid linking extra (unneeded) libraries.
	LDFLAGS+=" -Wl,--as-needed"

	# Basic hardening.
	CFLAGS+=" -fstack-protector-strong"
	LDFLAGS+=" -Wl,-z,relro,-z,now"

	if [ "$NEOTERM_DEBUG_BUILD" = "true" ]; then
		CFLAGS+=" -g3 -O1"
		CPPFLAGS+=" -D_FORTIFY_SOURCE=2 -D__USE_FORTIFY_LEVEL=2"
	else
		CFLAGS+=" -Oz"
	fi

	export CXXFLAGS="$CFLAGS"
	export CPPFLAGS+=" -I${NEOTERM_PREFIX}/include"

	# If libandroid-support is declared as a dependency, link to it explicitly:
	if [ "$NEOTERM_PKG_DEPENDS" != "${NEOTERM_PKG_DEPENDS/libandroid-support/}" ]; then
		LDFLAGS+=" -Wl,--no-as-needed,-landroid-support,--as-needed"
	fi

	export GOOS=android
	export CGO_ENABLED=1
	export GO_LDFLAGS="-extldflags=-pie"
	export CGO_LDFLAGS="${LDFLAGS/-Wl,-z,relro,-z,now/}"
	CGO_LDFLAGS="${LDFLAGS/-static-openmp/}"
	export CGO_CFLAGS="-I$NEOTERM_PREFIX/include"
	export RUSTFLAGS="-C link-arg=-Wl,-rpath=$NEOTERM_PREFIX/lib -C link-arg=-Wl,--enable-new-dtags"

	export ac_cv_func_getpwent=no
	export ac_cv_func_endpwent=yes
	export ac_cv_func_getpwnam=no
	export ac_cv_func_getpwuid=no
	export ac_cv_func_sigsetmask=no
	export ac_cv_c_bigendian=no

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
		return
	fi

	if [ -d $NEOTERM_STANDALONE_TOOLCHAIN ]; then
		for HOST_PLAT in aarch64-linux-android armv7a-linux-androideabi i686-linux-android x86_64-linux-android arm-linux-androideabi; do
			if [ "$NEOTERM_PKG_ENABLE_CLANG16_PORTING" = "true" ]; then
				cp $NEOTERM_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-clang.16-porting \
					$NEOTERM_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-clang
			else
				cp $NEOTERM_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-clang.no-16-porting \
					$NEOTERM_STANDALONE_TOOLCHAIN/bin/$HOST_PLAT-clang
			fi
		done
		return
	fi

	# Do not put toolchain in place until we are done with setup, to avoid having a half setup
	# toolchain left in place if something goes wrong (or process is just aborted):
	local _NEOTERM_TOOLCHAIN_TMPDIR=${NEOTERM_STANDALONE_TOOLCHAIN}-tmp
	rm -Rf $_NEOTERM_TOOLCHAIN_TMPDIR

	local _NDK_ARCHNAME=$NEOTERM_ARCH
	if [ "$NEOTERM_ARCH" = "aarch64" ]; then
		_NDK_ARCHNAME=arm64
	elif [ "$NEOTERM_ARCH" = "i686" ]; then
		_NDK_ARCHNAME=x86
	fi
	cp $NDK/toolchains/llvm/prebuilt/linux-x86_64 $_NEOTERM_TOOLCHAIN_TMPDIR -r

	# Remove android-support header wrapping not needed on android-21:
	rm -Rf $_NEOTERM_TOOLCHAIN_TMPDIR/sysroot/usr/local

	for HOST_PLAT in aarch64-linux-android armv7a-linux-androideabi i686-linux-android x86_64-linux-android; do
		cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT$NEOTERM_PKG_API_LEVEL-clang \
			$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang
		cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT$NEOTERM_PKG_API_LEVEL-clang++ \
			$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang++

		cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT$NEOTERM_PKG_API_LEVEL-clang \
			$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-cpp
		sed -i 's/clang/clang -E/' \
			$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-cpp

		cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang \
			$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-gcc
		cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang++ \
			$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-g++
	done

	cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/armv7a-linux-androideabi$NEOTERM_PKG_API_LEVEL-clang \
		$_NEOTERM_TOOLCHAIN_TMPDIR/bin/arm-linux-androideabi-clang
	cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/armv7a-linux-androideabi$NEOTERM_PKG_API_LEVEL-clang++ \
		$_NEOTERM_TOOLCHAIN_TMPDIR/bin/arm-linux-androideabi-clang++
	cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/armv7a-linux-androideabi-cpp \
		$_NEOTERM_TOOLCHAIN_TMPDIR/bin/arm-linux-androideabi-cpp

	for HOST_PLAT in aarch64-linux-android armv7a-linux-androideabi i686-linux-android x86_64-linux-android arm-linux-androideabi; do
		mv $_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang \
			$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang.no-16-porting
		cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang.no-16-porting \
			$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang.16-porting
		sed -i 's/"\$@"/--start-no-unused-arguments -Werror=implicit-function-declaration -Werror=implicit-int -Werror=int-conversion -Werror=incompatible-function-pointer-types --end-no-unused-arguments \0/g' \
			$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang.16-porting
		if [ "$NEOTERM_PKG_ENABLE_CLANG16_PORTING" = "true" ]; then
			cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang.16-porting \
				$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang
		else
			cp $_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang.no-16-porting \
				$_NEOTERM_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang
		fi
	done

	# rust 1.75.0+ expects this directory to be present
	rm -fr "${_NEOTERM_TOOLCHAIN_TMPDIR}"/toolchains
	mkdir -p "${_NEOTERM_TOOLCHAIN_TMPDIR}"/toolchains/llvm/prebuilt
	ln -fs ../../.. "${_NEOTERM_TOOLCHAIN_TMPDIR}"/toolchains/llvm/prebuilt/linux-x86_64

	# Create a pkg-config wrapper. We use path to host pkg-config to
	# avoid picking up a cross-compiled pkg-config later on.
	local _HOST_PKGCONFIG
	_HOST_PKGCONFIG=$(command -v pkg-config)
	mkdir -p "$PKG_CONFIG_LIBDIR"
	cat > $_NEOTERM_TOOLCHAIN_TMPDIR/bin/pkg-config <<-HERE
		#!/bin/sh
		export PKG_CONFIG_DIR=
		export PKG_CONFIG_LIBDIR=$PKG_CONFIG_LIBDIR
		exec $_HOST_PKGCONFIG "\$@"
	HERE
	chmod +x "$_NEOTERM_TOOLCHAIN_TMPDIR"/bin/pkg-config

	cd $_NEOTERM_TOOLCHAIN_TMPDIR/sysroot
	for f in $NEOTERM_SCRIPTDIR/ndk-patches/$NEOTERM_NDK_VERSION/*.patch; do
		echo "Applying ndk-patch: $(basename $f)"
		sed "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" "$f" | \
			sed "s%\@NEOTERM_HOME\@%${NEOTERM_ANDROID_HOME}%g" | \
			patch --silent -p1;
	done
	# libintl.h: Inline implementation gettext functions.
	# langinfo.h: Inline implementation of nl_langinfo().
	cp "$NEOTERM_SCRIPTDIR"/ndk-patches/{libintl.h,langinfo.h} usr/include

	# Remove <sys/capability.h> because it is provided by libcap.
	# Remove <sys/shm.h> from the NDK in favour of that from the libandroid-shmem.
	# Remove <sys/sem.h> as it doesn't work for non-root.
	# Remove <glob.h> as we currently provide it from libandroid-glob.
	# Remove <iconv.h> as it's provided by libiconv.
	# Remove <spawn.h> as it's only for future (later than android-27).
	# Remove <zlib.h> and <zconf.h> as we build our own zlib.
	# Remove unicode headers provided by libicu.
	# Remove KHR/khrplatform.h provided by mesa.
	# Remove NDK vulkan headers.
	rm usr/include/{sys/{capability,shm,sem},{glob,iconv,spawn,zlib,zconf},KHR/khrplatform}.h
	rm usr/include/unicode/{char16ptr,platform,ptypes,putil,stringoptions,ubidi,ubrk,uchar,uconfig,ucpmap,udisplaycontext,uenum,uldnames,ulocdata,uloc,umachine,unorm2,urename,uscript,ustring,utext,utf16,utf8,utf,utf_old,utypes,uvernum,uversion}.h
	rm -Rf usr/include/vulkan

	sed -i "s/define __ANDROID_API__ __ANDROID_API_FUTURE__/define __ANDROID_API__ $NEOTERM_PKG_API_LEVEL/" \
		usr/include/android/api-level.h

	$NEOTERM_ELF_CLEANER --api-level=$NEOTERM_PKG_API_LEVEL usr/lib/*/*/*.so
	for dir in usr/lib/*; do
		# This seem to be needed when building rust
		# packages
		echo 'INPUT(-lunwind)' > $dir/libgcc.a
	done

	grep -lrw $_NEOTERM_TOOLCHAIN_TMPDIR/sysroot/usr/include/c++/v1 -e '<version>' | xargs -n 1 sed -i 's/<version>/\"version\"/g'
	mv $_NEOTERM_TOOLCHAIN_TMPDIR $NEOTERM_STANDALONE_TOOLCHAIN
}
