NEOTERM_PKG_HOMEPAGE=https://www.openfoam.com
NEOTERM_PKG_DESCRIPTION="OpenFOAM is a CFD software written in C++"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_VERSION=2212
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://develop.openfoam.com/Development/openfoam/-/archive/OpenFOAM-v${NEOTERM_PKG_VERSION}/openfoam-OpenFOAM-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=424710fea228baec7ec677b5cb86821f8052ecde12ca36ab7ffba5ef601a2045
NEOTERM_PKG_DEPENDS="boost, libc++, libgmp, libmpfr, openmpi, readline, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, cgal, flex, libandroid-execinfo"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_RM_AFTER_INSTALL="opt/OpenFOAM-v${NEOTERM_PKG_VERSION}/build"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	(
		cd $NEOTERM_PKG_SRCDIR
		set +u
		source etc/bashrc WM_ARCH_OPTION=32 || true
		cd wmake/src
		make
		source ../../etc/bashrc WM_ARCH_OPTION=64 || true
		set -u
		make
	)
	mkdir -p platforms/tools
	mv $NEOTERM_PKG_SRCDIR/platforms/tools/linuxGcc platforms/tools/
	mv $NEOTERM_PKG_SRCDIR/platforms/tools/linux64Gcc platforms/tools/
}

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" == "aarch64" ]; then
		ARCH_FOLDER=linuxARM64Clang
		NEOTERM_COMPILER_PREFIX="aarch64-linux-android"
		ARCH=aarch64
	elif [ "$NEOTERM_ARCH" == "arm" ]; then
		ARCH_FOLDER=linuxARM7Clang
		NEOTERM_COMPILER_PREFIX="arm-linux-androideabi"
		ARCH=armv7l
	elif [ "$NEOTERM_ARCH" == "i686" ]; then
		ARCH_FOLDER=linuxClang
		NEOTERM_COMPILER_PREFIX="i686-linux-android"
		ARCH=i686
	elif [ "$NEOTERM_ARCH" == "x86_64" ]; then
		ARCH_FOLDER=linux64Clang
		NEOTERM_COMPILER_PREFIX="x86_64-linux-android"
		ARCH=x86_64
	fi
	sed -i "s%\@NEOTERM_COMPILER_PREFIX\@%${NEOTERM_COMPILER_PREFIX}%g" "$NEOTERM_PKG_SRCDIR/wmake/rules/General/Clang/c"
	sed -i "s%\@NEOTERM_COMPILER_PREFIX\@%${NEOTERM_COMPILER_PREFIX}%g" "$NEOTERM_PKG_SRCDIR/wmake/rules/General/Clang/c++"
	sed -i "s%\@NEOTERM_COMPILER_PREFIX\@%${NEOTERM_COMPILER_PREFIX}%g" "$NEOTERM_PKG_SRCDIR/wmake/rules/General/general"

	mkdir -p platforms/tools
	cp -r $NEOTERM_PKG_HOSTBUILD_DIR/platforms/tools/linux64Gcc platforms/tools/${ARCH_FOLDER}
	if [ $NEOTERM_ARCH_BITS = 32 ]; then
		cp -r $NEOTERM_PKG_HOSTBUILD_DIR/platforms/tools/linuxGcc platforms/tools/${ARCH_FOLDER}
	else
		cp -r $NEOTERM_PKG_HOSTBUILD_DIR/platforms/tools/linux64Gcc platforms/tools/${ARCH_FOLDER}
	fi
}

neoterm_step_make() {
	# Set ARCH here again so that continued builds work
	if [ "$NEOTERM_ARCH" == "aarch64" ]; then
		ARCH=aarch64
	elif [ "$NEOTERM_ARCH" == "arm" ]; then
		ARCH=armv7l
	elif [ "$NEOTERM_ARCH" == "i686" ]; then
		ARCH=i686
	elif [ "$NEOTERM_ARCH" == "x86_64" ]; then
		ARCH=x86_64
	fi

	# Lots and lots of unset env. variables that "set -u"
	# complains about, so disable exit on error temporarily
	set +u
	source "$NEOTERM_PKG_SRCDIR"/etc/bashrc || true
	set -u
	unset LD_LIBRARY_PATH
	./Allwmake
	cd wmake/src
	make clean
	make
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/opt
	cp -a $NEOTERM_PKG_SRCDIR $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/opt/OpenFOAM-v${NEOTERM_PKG_VERSION}
}

neoterm_step_post_make_install() {
	sed -i 's%$ARCH%$(uname -m)%g' $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/opt/OpenFOAM-v${NEOTERM_PKG_VERSION}/etc/config.sh/settings
}
