NEOTERM_PKG_HOMEPAGE=https://pypy.org
NEOTERM_PKG_DESCRIPTION="A fast, compliant alternative implementation of Python 3"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@licy183"
_MAJOR_VERSION=3.9
NEOTERM_PKG_VERSION=7.3.13
NEOTERM_PKG_SRCURL=https://downloads.python.org/pypy/pypy$_MAJOR_VERSION-v$NEOTERM_PKG_VERSION-src.tar.bz2
NEOTERM_PKG_SHA256=bc6147268105e7cb3bd57b401e6d97f66aa4ede269104b2712a7cdd9f02f68cd
NEOTERM_PKG_DEPENDS="gdbm, libandroid-posix-semaphore, libandroid-support, libbz2, libcrypt, libexpat, libffi, liblzma, libsqlite, ncurses, ncurses-ui-libs, openssl, zlib"
NEOTERM_PKG_BUILD_DEPENDS="binutils, clang, dash, make, ndk-multilib, pkg-config, python2, tk, xorgproto"
NEOTERM_PKG_RECOMMENDS="clang, make, pkg-config"
NEOTERM_PKG_SUGGESTS="pypy3-tkinter"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_RM_AFTER_INSTALL="
opt/pypy3/lib/pypy$_MAJOR_VERSION/test
opt/pypy3/lib/pypy$_MAJOR_VERSION/*/test
opt/pypy3/lib/pypy$_MAJOR_VERSION/*/tests
"

_docker_pull_url=https://raw.githubusercontent.com/NotGlop/docker-drag/5413165a2453aa0bc275d7dc14aeb64e814d5cc0/docker_pull.py
_docker_pull_checksums=04e52b70c862884e75874b2fd229083fdf09a4bac35fc16fd7a0874ba20bd075
_undocker_url=https://raw.githubusercontent.com/larsks/undocker/649f3fdeb0a9cf8aa794d90d6cc6a7c7698a25e6/undocker.py
_undocker_checksums=32bc122c53153abeb27491e6d45122eb8cef4f047522835bedf9b4b87877a907
_proot_url=https://github.com/proot-me/proot/releases/download/v5.3.0/proot-v5.3.0-x86_64-static
_proot_checksums=d1eb20cb201e6df08d707023efb000623ff7c10d6574839d7bb42d0adba6b4da
_qemu_aarch64_static_url=https://github.com/multiarch/qemu-user-static/releases/download/v7.2.0-1/qemu-aarch64-static
_qemu_aarch64_static_checksums=dce64b2dc6b005485c7aa735a7ea39cb0006bf7e5badc28b324b2cd0c73d883f
_qemu_arm_static_url=https://github.com/multiarch/qemu-user-static/releases/download/v7.2.0-1/qemu-arm-static
_qemu_arm_static_checksums=9f07762a3cd0f8a199cb5471a92402a4765f8e2fcb7fe91a87ee75da9616a806

# Skip due to we use proot to get dependencies
neoterm_step_get_dependencies() {
	echo "Skip due to we use proot to get dependencies"
}

neoterm_step_override_config_scripts() {
	:
}

neoterm_step_pre_configure() {
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	local p="$NEOTERM_PKG_BUILDER_DIR/9998-link-against-pypy3-on-testcapi.diff"
	echo "Applying $(basename "${p}")"
	sed 's|@NEOTERM_PYPY_MAJOR_VERSION@|'"${_MAJOR_VERSION}"'|g' "${p}" \
		| patch --silent -p1

	local p="$NEOTERM_PKG_BUILDER_DIR/9999-add-ANDROID_API_LEVEL-for-sysconfigdata.diff"
	echo "Applying $(basename "${p}")"
	sed 's|@NEOTERM_PKG_API_LEVEL@|'"${NEOTERM_PKG_API_LEVEL}"'|g' "${p}" \
		| patch --silent -p1

	DOCKER_PULL="python $NEOTERM_PKG_CACHEDIR/docker_pull.py"
	UNDOCKER="python $NEOTERM_PKG_CACHEDIR/undocker.py"
	PROOT="$NEOTERM_PKG_CACHEDIR/proot"

	# Get docker_pull.py
	neoterm_download \
		$_docker_pull_url \
		$NEOTERM_PKG_CACHEDIR/docker_pull.py \
		$_docker_pull_checksums

	# Get undocker.py
	neoterm_download \
		$_undocker_url \
		$NEOTERM_PKG_CACHEDIR/undocker.py \
		$_undocker_checksums
	
	# Get proot
	neoterm_download \
		$_proot_url \
		$PROOT \
		$_proot_checksums
	
	chmod +x $PROOT

	# Get qemu-aarch64-static
	neoterm_download \
		$_qemu_aarch64_static_url \
		$NEOTERM_PKG_CACHEDIR/qemu-aarch64-static \
		$_qemu_aarch64_static_checksums

	chmod +x $NEOTERM_PKG_CACHEDIR/qemu-aarch64-static

	# Get qemu-arm-static
	neoterm_download \
		$_qemu_arm_static_url \
		$NEOTERM_PKG_CACHEDIR/qemu-arm-static \
		$_qemu_arm_static_checksums

	chmod +x $NEOTERM_PKG_CACHEDIR/qemu-arm-static

	# Pick up host platform arch.
	HOST_ARCH=$NEOTERM_ARCH
	if [ $NEOTERM_ARCH = "arm" ]; then
		HOST_ARCH="i686"
	elif [ $NEOTERM_ARCH = "aarch64" ]; then
		HOST_ARCH="x86_64"
	fi

	# Get host platform rootfs tar if needed.
	if [ ! -f "$NEOTERM_PKG_CACHEDIR/neoterm_neoterm-docker_$HOST_ARCH.tar" ]; then
		(
			cd $NEOTERM_PKG_CACHEDIR
			$DOCKER_PULL ghcr.io/neoterm-user-repository/neoterm-docker:$HOST_ARCH
			mv neoterm-user-repository_neoterm-docker.tar neoterm_neoterm-docker_$HOST_ARCH.tar
		)
	fi

	# Get target platform rootfs tar if needed.
	if [ $HOST_ARCH != $NEOTERM_ARCH ]; then
		# Check qemu version, must greater than 6.0.0, since qemu 4/5 cannot run python
		# inside the neoterm rootfs and will cause a segmentation fault, and qemu 6 hangs
		# on clang++
		QEMU_VERSION=$($NEOTERM_PKG_CACHEDIR/qemu-$NEOTERM_ARCH-static --version | grep "version" | sed -E "s/.*?version (.*?)/\1/g")
		QEMU_MAJOR_VERSION=${QEMU_VERSION%%.*}
		if [ $QEMU_MAJOR_VERSION -lt '7' ]; then
			neoterm_error_exit "qemu-user-static's version must be greater than 7.0.0"
		fi
		if [ ! -f "$NEOTERM_PKG_CACHEDIR/neoterm_neoterm-docker_$NEOTERM_ARCH.tar" ]; then
			(
				cd $NEOTERM_PKG_CACHEDIR
				$DOCKER_PULL ghcr.io/neoterm-user-repository/neoterm-docker:$NEOTERM_ARCH
				mv neoterm-user-repository_neoterm-docker.tar neoterm_neoterm-docker_$NEOTERM_ARCH.tar
			)
		fi
	fi
}

neoterm_step_configure() {
	PYPY_USESSION_DIR=$NEOTERM_ANDROID_HOME/tmp
	PYPY_SRC_DIR=$NEOTERM_ANDROID_HOME/src

	# Bootstrap a proot rootfs for the host platform
	HOST_ROOTFS_BASE=$NEOTERM_PKG_TMPDIR/host-rootfs
	cat "$NEOTERM_PKG_CACHEDIR/neoterm_neoterm-docker_$HOST_ARCH.tar" | $UNDOCKER -o $HOST_ROOTFS_BASE

	# Add build dependicies for pypy on the host platform rootfs
	# Build essential
	BUILD_DEP="binutils binutils-gold clang file patch pkg-config "
	# Build dependencies for pypy
	BUILD_DEP+=${NEOTERM_PKG_DEPENDS//,/}
	BUILD_DEP+=" "
	BUILD_DEP+=${NEOTERM_PKG_BUILD_DEPENDS//,/}

	# Environment variables for neoterm
	NEOTERM_RUNTIME_ENV_VARS="ANDROID_DATA=/data
			ANDROID_ROOT=/system
			HOME=$NEOTERM_ANDROID_HOME
			LANG=en_US.UTF-8
			PATH=$NEOTERM_PREFIX/bin:/usr/bin
			PREFIX=$NEOTERM_PREFIX
			TMPDIR=$NEOTERM_PREFIX/tmp
			TZ=UTC"
	ln -s $HOST_ROOTFS_BASE/$NEOTERM_ANDROID_HOME/ $NEOTERM_ANDROID_HOME
	ln -s $NEOTERM_PKG_SRCDIR $PYPY_SRC_DIR
	PROOT_HOST="env -i PROOT_NO_SECCOMP=1
						$NEOTERM_RUNTIME_ENV_VARS
						$PROOT 
						-b /proc -b /dev -b /sys
						-b $HOME
						-b $NEOTERM_ANDROID_HOME
						-w $NEOTERM_ANDROID_HOME
						-r $HOST_ROOTFS_BASE/"
	# Get dependencies
	$PROOT_HOST update-static-dns
	sed -i "s/deb/deb [trusted=yes]/g" $HOST_ROOTFS_BASE/$NEOTERM_PREFIX/etc/apt/sources.list
	$PROOT_HOST apt update
	$PROOT_HOST apt upgrade -yq -o Dpkg::Options::=--force-confnew
	sed -i "s/deb/deb [trusted=yes]/g" $HOST_ROOTFS_BASE/$NEOTERM_PREFIX/etc/apt/sources.list
	$PROOT_HOST apt update
	$PROOT_HOST apt install -o Dpkg::Options::=--force-confnew -yq $BUILD_DEP
	$PROOT_HOST python2 -m pip install cffi pycparser

	# Copy the statically-built proot
	cp $PROOT $HOST_ROOTFS_BASE/$NEOTERM_PREFIX/bin/

	# Extract the target platform rootfs to the host platform rootfs if needed.
	PROOT_TARGET="$PROOT_HOST"
	TARGET_ROOTFS_BASE=""
	if [ $HOST_ARCH != $NEOTERM_ARCH ]; then
		TARGET_ROOTFS_BASE=$NEOTERM_ANDROID_HOME/target-rootfs
		mkdir -p $HOST_ROOTFS_BASE/$TARGET_ROOTFS_BASE
		cat "$NEOTERM_PKG_CACHEDIR/neoterm_neoterm-docker_$NEOTERM_ARCH.tar" | $UNDOCKER -o $HOST_ROOTFS_BASE/$TARGET_ROOTFS_BASE
		PROOT_TARGET="env -i PROOT_NO_SECCOMP=1
			$NEOTERM_RUNTIME_ENV_VARS
			$PROOT
			-q $NEOTERM_PKG_CACHEDIR/qemu-$NEOTERM_ARCH-static
			-b $HOME
			-b $NEOTERM_ANDROID_HOME
			-b /proc -b /dev -b /sys
			-w $NEOTERM_ANDROID_HOME
			-r $TARGET_ROOTFS_BASE"
		# Check if it can be run with or without $PROOT_HOST
		$PROOT_HOST $PROOT_TARGET uname -a
		$PROOT_TARGET uname -a
		# update-static-dns will use the arm busybox binary.
		${PROOT_TARGET/qemu-$NEOTERM_ARCH-static/qemu-arm-static} update-static-dns
		# FIXME: If we don't add `[trusted=yes]`, apt-key will generate an error.
		# FIXME: The key(s) in the keyring XXX.gpg are ignored as the file is not readable by user '' executing apt-key.
		sed -i "s/deb/deb [trusted=yes]/g" $HOST_ROOTFS_BASE/$TARGET_ROOTFS_BASE/$NEOTERM_PREFIX/etc/apt/sources.list
		$PROOT_TARGET apt update
		$PROOT_TARGET apt install -o Dpkg::Options::=--force-confnew -yq dash
		# Use dash to provide /system/bin/sh, since /system/bin/sh is a symbolic link
		# to /system/bin/busybox which is a 32-bit binary. If we are using an aarch64
		# qemu, proot cannot execute it.
		rm -f $HOST_ROOTFS_BASE/$TARGET_ROOTFS_BASE/system/bin/sh
		$PROOT_TARGET ln -sf $NEOTERM_PREFIX/bin/dash /system/bin/sh
		# Get dependencies
		$PROOT_TARGET apt update
		$PROOT_TARGET apt upgrade -yq -o Dpkg::Options::=--force-confnew
		sed -i "s/deb/deb [trusted=yes]/g" $HOST_ROOTFS_BASE/$TARGET_ROOTFS_BASE/$NEOTERM_PREFIX/etc/apt/sources.list
		$PROOT_TARGET apt update
		$PROOT_TARGET apt install -o Dpkg::Options::=--force-confnew -yq $BUILD_DEP
		# `pip2` is set up in the postinst script of `python2`, but it will segfault on aarch64. Install it manually.
		$PROOT_TARGET python2 -m ensurepip
		# Use the target rootfs providing $NEOTERM_PREFIX
		if [ ! -L $NEOTERM_PREFIX ]; then
			if [ -d $NEOTERM_PREFIX.backup ]; then
				rm -rf $NEOTERM_PREFIX.backup
			fi
			mv $NEOTERM_PREFIX $NEOTERM_PREFIX.backup
			ln -s $HOST_ROOTFS_BASE/$TARGET_ROOTFS_BASE/$NEOTERM_PREFIX $NEOTERM_PREFIX
		fi
		# Install cffi and pycparser
		$PROOT_TARGET python2 -m pip install cffi pycparser
	fi
}

neoterm_step_make() {
	mkdir -p $HOST_ROOTFS_BASE/$PYPY_USESSION_DIR

	# Translation
	$PROOT_HOST env -i \
			-C $PYPY_SRC_DIR/pypy/goal \
			$NEOTERM_RUNTIME_ENV_VARS \
			PYPY_USESSION_DIR=$PYPY_USESSION_DIR \
			TARGET_ROOTFS_BASE=$TARGET_ROOTFS_BASE \
			PROOT_TARGET="$PROOT_TARGET" \
			$NEOTERM_PREFIX/bin/python2 -u ../../rpython/bin/rpython \
					--platform=neoterm-$NEOTERM_ARCH \
					--source --no-compile -Ojit \
					targetpypystandalone.py

	# Build
	cd $PYPY_USESSION_DIR
	cd $(ls -C | awk '{print $1}')/testing_1
	$PROOT_HOST env -C $(pwd) make clean
	$PROOT_HOST env -C $(pwd) make -j$NEOTERM_MAKE_PROCESSES

	# Copy the built files
	cp ./pypy$_MAJOR_VERSION-c $PYPY_SRC_DIR/pypy/goal/pypy$_MAJOR_VERSION-c || bash
	cp ./libpypy$_MAJOR_VERSION-c.so $PYPY_SRC_DIR/pypy/goal/libpypy$_MAJOR_VERSION-c.so || bash
	cp ./libpypy$_MAJOR_VERSION-c.so $HOST_ROOTFS_BASE/$TARGET_ROOTFS_BASE/$NEOTERM_PREFIX/lib/libpypy$_MAJOR_VERSION-c.so || bash

	# Build cffi imports
	TARGET_CFLAGS="-I$NEOTERM_PREFIX/include -Wno-incompatible-function-pointer-types -Wno-implicit-function-declaration"
	TARGET_LDFLAGS="-L$NEOTERM_PREFIX/lib -fno-neoterm-rpath -Wl,-rpath=$NEOTERM_PREFIX/lib"
	$PROOT_TARGET env \
				CC=cc \
				NEOTERM_STANDALONE_TOOLCHAIN=$NEOTERM_STANDALONE_TOOLCHAIN \
				CFLAGS="$TARGET_CFLAGS" \
				LDFLAGS="$TARGET_LDFLAGS" \
				python2 $PYPY_SRC_DIR/pypy/tool/release/package.py \
					--archive-name=pypy$_MAJOR_VERSION-v$NEOTERM_PKG_VERSION \
					--targetdir=$PYPY_SRC_DIR \
					--no-keep-debug
	rm -f $NEOTERM_PREFIX/lib/libpypy$_MAJOR_VERSION-c.so
}

neoterm_step_make_install() {
	# Recover $NEOTERM_PREFIX
	if [ $HOST_ARCH != $NEOTERM_ARCH ]; then
		rm -rf $NEOTERM_PREFIX
		mv $NEOTERM_PREFIX.backup $NEOTERM_PREFIX
	fi
	rm -rf $NEOTERM_PREFIX/opt/pypy3
	unzip -d $NEOTERM_PREFIX/opt/ pypy$_MAJOR_VERSION-v$NEOTERM_PKG_VERSION.zip
	mv $NEOTERM_PREFIX/opt/pypy$_MAJOR_VERSION-v$NEOTERM_PKG_VERSION $NEOTERM_PREFIX/opt/pypy3
	ln -sfr $NEOTERM_PREFIX/opt/pypy3/bin/pypy3 $NEOTERM_PREFIX/bin/
	ln -sfr $NEOTERM_PREFIX/opt/pypy3/bin/libpypy3-c.so $NEOTERM_PREFIX/lib/
}

neoterm_step_create_debscripts() {
	# Pre-rm script to cleanup runtime-generated files.
	cat <<- PRERM_EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh

	if [ "$NEOTERM_PACKAGE_FORMAT" != "pacman" ] && [ "\$1" != "remove" ]; then
	    exit 0
	fi

	echo "Deleting files from site-packages..."
	rm -Rf $NEOTERM_PREFIX/opt/pypy3/lib/pypy$_MAJOR_VERSION/site-packages/*

	echo "Deleting *.pyc..."
	find $NEOTERM_PREFIX/opt/pypy3/lib/ | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

	exit 0
	PRERM_EOF

	chmod 0755 prerm
}

neoterm_step_post_make_install() {
	rm -rf $NEOTERM_ANDROID_HOME
}
