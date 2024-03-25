NEOTERM_PKG_HOMEPAGE=https://www.frida.re/
NEOTERM_PKG_DESCRIPTION="Dynamic instrumentation toolkit for developers, reverse-engineers, and security researchers"
NEOTERM_PKG_LICENSE="wxWindows"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
_MAJOR_VERSION=16
_MINOR_VERSION=1
_MICRO_VERSION=1
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.${_MINOR_VERSION}.${_MICRO_VERSION}
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_SRCURL=git+https://github.com/frida/frida
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libiconv"
NEOTERM_PKG_BUILD_DEPENDS="openssl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="ANDROID_NDK_ROOT=$NDK"
NEOTERM_PKG_CONFFILES="var/service/frida-server/run var/service/frida-server/down"
NEOTERM_PKG_CONFLICTS="frida-tools (<< 15.1.24-1)"
NEOTERM_PKG_BREAKS="frida-server (<< 15.1.24)"
NEOTERM_PKG_REPLACES="frida-tools (<< 15.1.24-1), frida-server (<< 15.1.24)"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	neoterm_setup_nodejs

	# make and save frida-resource-compiler in hostbuild step,
	# otherwise the one that is compiled in neoterm_step_make
	# segfaults (seem to be some tool in neoterm's toolchain bin
	# dir that causes it, removing our bin/ dir from PATH fixes
	# the issue)
	cd $NEOTERM_PKG_SRCDIR
	make core-linux-x86_64 ${NEOTERM_PKG_EXTRA_MAKE_ARGS}
	cp build/tmp-linux-x86_64/frida-core/tools/frida-resource-compiler \
		$NEOTERM_PKG_HOSTBUILD_DIR/
}


neoterm_step_pre_configure () {
	neoterm_setup_nodejs

	export NEOTERM_PKG_EXTRA_MAKE_ARGS+=" PYTHON=/usr/bin/python${NEOTERM_PYTHON_VERSION}"
	sed -e "s%@NEOTERM_PREFIX@%$NEOTERM_PREFIX%g" \
		-e "s%@PYTHON_VERSION@%$NEOTERM_PYTHON_VERSION%g" \
		$NEOTERM_PKG_BUILDER_DIR/frida-python-version.diff | patch -Np1
}

neoterm_step_make () {
	if [[ ${NEOTERM_ARCH} == "aarch64" ]]; then
		arch=arm64
	elif [[ ${NEOTERM_ARCH} == "i686" ]]; then
		arch=x86
	else
		arch=${NEOTERM_ARCH}
	fi

	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR:$PATH

	CC=gcc CXX=g++ make python-android-${arch} ${NEOTERM_PKG_EXTRA_MAKE_ARGS}
	CC=gcc CXX=g++ make tools-android-${arch} ${NEOTERM_PKG_EXTRA_MAKE_ARGS}
}

neoterm_step_make_install () {
	install build/frida-android-${arch}/bin/frida \
		build/frida-android-${arch}/bin/frida-apk \
		build/frida-android-${arch}/bin/frida-create \
		build/frida-android-${arch}/bin/frida-discover \
		build/frida-android-${arch}/bin/frida-inject \
		build/frida-android-${arch}/bin/frida-kill \
		build/frida-android-${arch}/bin/frida-ls-devices \
		build/frida-android-${arch}/bin/frida-portal \
		build/frida-android-${arch}/bin/frida-ps \
		build/frida-android-${arch}/bin/frida-server \
		build/frida-android-${arch}/bin/frida-trace \
		build/frida-android-${arch}/bin/gum-graft \
		${NEOTERM_PREFIX}/bin/
	install build/frida-android-${arch}/lib/{*.so,*.a} ${NEOTERM_PREFIX}/lib/
	cp -r build/frida-android-${arch}/lib/{pkgconfig,python*} ${NEOTERM_PREFIX}/lib/
	cp -r build/frida-android-${arch}/include/frida-* ${NEOTERM_PREFIX}/include/
	cp -r build/frida-android-${arch}/share/vala ${NEOTERM_PREFIX}/share/
}

neoterm_step_post_make_install () {
	# Setup neoterm-services scripts
	mkdir -p $NEOTERM_PREFIX/var/service/frida-server/log
	{
		echo "#!$NEOTERM_PREFIX/bin/sh"
		echo "unset LD_PRELOAD"
		echo "exec su -c $NEOTERM_PREFIX/bin/frida-server 2>&1"
	} > $NEOTERM_PREFIX/var/service/frida-server/run

	# Unfortunately, running sv down frida-server just kills the "su" process but leaves frida-server
	# running (even though it is running in the foreground). This finish script works around that.
	{
		echo "#!$NEOTERM_PREFIX/bin/sh"
		echo "su -c pkill -9 frida-server"
	} > $NEOTERM_PREFIX/var/service/frida-server/finish
	chmod u+x $NEOTERM_PREFIX/var/service/frida-server/run $NEOTERM_PREFIX/var/service/frida-server/finish

	ln -sf $NEOTERM_PREFIX/share/neoterm-services/svlogger $NEOTERM_PREFIX/var/service/frida-server/log/run

	touch $NEOTERM_PREFIX/var/service/frida-server/down
}
