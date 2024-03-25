NEOTERM_PKG_HOMEPAGE=https://github.com/PojavLauncherTeam/mobile
NEOTERM_PKG_DESCRIPTION="Java development kit and runtime"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=17.0
NEOTERM_PKG_REVISION=29
NEOTERM_PKG_SRCURL=https://github.com/neoterm/openjdk-mobile-neoterm/archive/ec285598849a27f681ea6269342cf03cf382eb56.tar.gz
NEOTERM_PKG_SHA256=d7c6ead9d80d0f60d98d0414e9dc87f5e18a304e420f5cd21f1aa3210c1a1528
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libiconv, libjpeg-turbo, zlib"
NEOTERM_PKG_BUILD_DEPENDS="cups, libandroid-spawn, xorgproto"
# openjdk-17-x is recommended because X11 separation is still very experimental.
NEOTERM_PKG_RECOMMENDS="ca-certificates-java, openjdk-17-x, resolv-conf"
NEOTERM_PKG_SUGGESTS="cups"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HAS_DEBUG=false

neoterm_step_pre_configure() {
	unset JAVA_HOME

	# Provide fake gcc.
	mkdir -p $NEOTERM_PKG_SRCDIR/wrappers-bin
	cat <<- EOF > $NEOTERM_PKG_SRCDIR/wrappers-bin/android-wrapped-clang
	#!/bin/bash
	name=\$(basename "\$0")
	if [ "\$name" = "android-wrapped-clang" ]; then
		name=gcc
		compiler=$CC
	else
		name=g++
		compiler=$CXX
	fi
	if [ "\$1" = "--version" ]; then
		echo "${NEOTERM_HOST_PLATFORM/arm/armv7a}-\${name} (GCC) 4.9 20140827 (prerelease)"
		echo "Copyright (C) 2014 Free Software Foundation, Inc."
		echo "This is free software; see the source for copying conditions.  There is NO"
		echo "warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
		exit 0
	fi
	exec \$compiler "\${@/-fno-var-tracking-assignments/}"
	EOF
	chmod +x $NEOTERM_PKG_SRCDIR/wrappers-bin/android-wrapped-clang
	ln -sfr $NEOTERM_PKG_SRCDIR/wrappers-bin/android-wrapped-clang \
		$NEOTERM_PKG_SRCDIR/wrappers-bin/android-wrapped-clang++
	CC=$NEOTERM_PKG_SRCDIR/wrappers-bin/android-wrapped-clang
	CXX=$NEOTERM_PKG_SRCDIR/wrappers-bin/android-wrapped-clang++

	cat <<- EOF > $NEOTERM_PKG_TMPDIR/devkit.info
	DEVKIT_NAME="Android"
	DEVKIT_TOOLCHAIN_PATH="\$DEVKIT_ROOT"
	DEVKIT_SYSROOT="\$DEVKIT_ROOT/sysroot"
	EOF

	cp -rT $NEOTERM_STANDALONE_TOOLCHAIN/sysroot $NEOTERM_PKG_TMPDIR/sysroot
}

neoterm_step_configure() {
	local jdk_ldflags="-L${NEOTERM_PREFIX}/lib -Wl,-rpath=$NEOTERM_PREFIX/opt/openjdk/lib -Wl,-rpath=${NEOTERM_PREFIX}/lib -Wl,--enable-new-dtags"
	bash ./configure \
		--openjdk-target=$NEOTERM_HOST_PLATFORM \
		--with-extra-cflags="$CFLAGS $CPPFLAGS -DLE_STANDALONE -DANDROID -D__NEOTERM__=1" \
		--with-extra-cxxflags="$CXXFLAGS $CPPFLAGS -DLE_STANDALONE -DANDROID -D__NEOTERM__=1" \
		--with-extra-ldflags="${jdk_ldflags} -Wl,--as-needed -landroid-shmem" \
		--disable-precompiled-headers \
		--disable-warnings-as-errors \
		--enable-option-checking=fatal \
		--with-toolchain-type=gcc \
		--with-jvm-variants=server \
		--with-devkit="$NEOTERM_PKG_TMPDIR" \
		--with-debug-level=release \
		--with-cups-include="$NEOTERM_PREFIX/include" \
		--with-fontconfig-include="$NEOTERM_PREFIX/include" \
		--with-freetype-include="$NEOTERM_PREFIX/include/freetype2" \
		--with-freetype-lib="$NEOTERM_PREFIX/lib" \
		--with-giflib=system \
		--with-libjpeg=system \
		--with-libpng=system \
		--with-zlib=system \
		--x-includes="$NEOTERM_PREFIX/include/X11" \
		--x-libraries="$NEOTERM_PREFIX/lib" \
		--with-x="$NEOTERM_PREFIX/include/X11" \
		AR="$AR" \
		NM="$NM" \
		OBJCOPY="$OBJCOPY" \
		OBJDUMP="$OBJDUMP" \
		STRIP="$STRIP"
}

neoterm_step_make() {
	cd build/linux-${NEOTERM_ARCH/i686/x86}-server-release
	make JOBS=1 images
}

neoterm_step_make_install() {
	rm -rf $NEOTERM_PREFIX/opt/openjdk
	mkdir -p $NEOTERM_PREFIX/opt/openjdk
	cp -r build/linux-${NEOTERM_ARCH/i686/x86}-server-release/images/jdk/* \
		$NEOTERM_PREFIX/opt/openjdk/
	find $NEOTERM_PREFIX/opt/openjdk -name "*.debuginfo" -delete

	# OpenJDK is not installed into /prefix/bin.
	local i
	for i in $NEOTERM_PREFIX/opt/openjdk/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr "$i" "$NEOTERM_PREFIX/bin/$(basename "$i")"
	done

	# Link manpages to location accessible by "man".
	mkdir -p $NEOTERM_PREFIX/share/man/man1
	for i in $NEOTERM_PREFIX/opt/openjdk/man/man1/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		gzip "$i"
		ln -sfr "${i}.gz" "$NEOTERM_PREFIX/share/man/man1/$(basename "$i").gz"
	done

	# Dependent projects may need JAVA_HOME.
	mkdir -p $NEOTERM_PREFIX/etc/profile.d
	echo "export JAVA_HOME=$NEOTERM_PREFIX/opt/openjdk" > \
		$NEOTERM_PREFIX/etc/profile.d/java.sh
}
