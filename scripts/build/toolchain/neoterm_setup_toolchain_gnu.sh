neoterm_setup_toolchain_gnu() {
	export CFLAGS="-O2 -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security -fstack-clash-protection"
	export CPPFLAGS=""
	export LDFLAGS=""

	export CC=$NEOTERM_HOST_PLATFORM-gcc
	export CXX=$NEOTERM_HOST_PLATFORM-g++
	export AR=$NEOTERM_HOST_PLATFORM-gcc-ar
	export RANLIB=$NEOTERM_HOST_PLATFORM-gcc-ranlib
	export NM=$NEOTERM_HOST_PLATFORM-gcc-nm
	export LD=ld
	export AS=as
	export OBJCOPY=objcopy
	export OBJDUMP=objdump
	export READELF=readelf
	export STRIP=strip
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
		export CXXFILT=c++filt
	else
		export CXXFILT=$NEOTERM_HOST_PLATFORM-c++filt
	fi

	export PATH_DYNAMIC_LINKER="$NEOTERM_PREFIX/lib/"
	if [ "$NEOTERM_ARCH" = "aarch64" ]; then
		CFLAGS+=" -march=armv8-a"
		PATH_DYNAMIC_LINKER+="ld-linux-aarch64.so.1"
	elif [ "$NEOTERM_ARCH" = "arm" ]; then
		CFLAGS+=" -march=armv7-a -mfloat-abi=hard -mfpu=neon"
		PATH_DYNAMIC_LINKER+="ld-linux-armhf.so.3"
	elif [ "$NEOTERM_ARCH" = "x86_64" ]; then
		CFLAGS+=" -march=x86-64 -fPIC"
		PATH_DYNAMIC_LINKER+="ld-linux-x86-64.so.2"
	elif [ "$NEOTERM_ARCH" = "i686" ]; then
		CFLAGS+=" -march=i686"
		PATH_DYNAMIC_LINKER+="ld-linux.so.2"
	fi

	case "$NEOTERM_ARCH" in
		"aarch64"|"arm") CFLAGS+=" -fstack-protector-strong";;
		"x86_64"|"i686") CFLAGS+=" -mtune=generic -fcf-protection";;
	esac

 	export CCNEOTERM_HOST_PLATFORM=$NEOTERM_HOST_PLATFORM

	export PKG_CONFIG=pkg-config
	export PKGCONFIG=$PKG_CONFIG
 	export PKG_CONFIG_LIBDIR="$NEOTERM_PKG_CONFIG_LIBDIR"

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		if ! $(echo "$PATH" | grep -q "^$NEOTERM_STANDALONE_TOOLCHAIN/bin:"); then
			export PATH="$NEOTERM_STANDALONE_TOOLCHAIN/bin:$PATH"
		fi
  		if ! $(echo "$PATH" | grep -q ":$NEOTERM_PREFIX/bin"); then
			export PATH="$PATH:$NEOTERM_PREFIX/bin"
		fi
	fi

	export CXXFLAGS="$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"
}
