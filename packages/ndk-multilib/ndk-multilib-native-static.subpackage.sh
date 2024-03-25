NEOTERM_SUBPKG_DESCRIPTION="Install native static libs from NDK"
# Existence of libfoo.a without stub libfoo.so causes troubles.
NEOTERM_SUBPKG_DEPENDS="ndk-multilib-native-stubs"
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=false
NEOTERM_SUBPKG_INCLUDE=

case "$NEOTERM_ARCH" in
	aarch64 )
		NEOTERM_SUBPKG_INCLUDE+="
			aarch64-linux-android/lib/libc.a
			aarch64-linux-android/lib/libdl.a
			aarch64-linux-android/lib/libm.a
		"
		;& # fallthrough
	arm )
		NEOTERM_SUBPKG_INCLUDE+="
			arm-linux-androideabi/lib/libc.a
			arm-linux-androideabi/lib/libdl.a
			arm-linux-androideabi/lib/libm.a
		"
		;;
	x86_64 )
		NEOTERM_SUBPKG_INCLUDE+="
			x86_64-linux-android/lib/libc.a
			x86_64-linux-android/lib/libdl.a
			x86_64-linux-android/lib/libm.a
		"
		;& # fallthrough
	i686 )
		NEOTERM_SUBPKG_INCLUDE+="
			i686-linux-android/lib/libc.a
			i686-linux-android/lib/libdl.a
			i686-linux-android/lib/libm.a
		"
		;;
esac
