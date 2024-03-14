NEOTERM_PKG_HOMEPAGE=https://www.oorexx.org/
NEOTERM_PKG_DESCRIPTION="Open Object Rexx"
NEOTERM_PKG_LICENSE="CPL-1.0"
NEOTERM_PKG_LICENSE_FILE="CPLv1.0.txt, NOTICE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.2.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/oorexx/oorexx/${NEOTERM_PKG_VERSION}/ooRexx-${NEOTERM_PKG_VERSION}-source.tar.gz
NEOTERM_PKG_SHA256=ac5af11e7d4d239d2ebe06f40092f4aebf87fc40740b46458bff3b4069ce6e0b
NEOTERM_PKG_DEPENDS="libandroid-posix-semaphore, libandroid-wordexp, libc++, libcrypt"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_catopen=no"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="CFLAGS=-O0"

neoterm_step_post_get_source() {
	sed -i 's:__type:_&:g' api/oorexxapi.h
}

neoterm_step_pre_configure() {
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR:$PATH

	CFLAGS+=" -fwrapv -fno-strict-aliasing"
	LDFLAGS+=" -landroid-posix-semaphore"
	LDFLAGS+=" -landroid-wordexp -lcrypt $($CC -print-libgcc-file-name)"

	local _SOVERSION=${NEOTERM_PKG_VERSION%%.*}

	local dummylibdir=$NEOTERM_PKG_BUILDDIR/_dummylib
	mkdir -p $dummylibdir
	echo 'void RexxVariablePool(void){}' | $CC -x c - -shared -nostdlib \
		-Wl,-soname=librexx.so.${_SOVERSION} \
		-o $dummylibdir/librexx.so
	echo 'void RexxFreeMemory(void){}' | $CC -x c - -shared -nostdlib \
		-Wl,-soname=librexxapi.so.${_SOVERSION} \
		-o $dummylibdir/librexxapi.so
	export DLDFLAGS="-L./.libs -L${dummylibdir}"
}

neoterm_step_post_configure() {
	sed -i 's:\./\(rexximage\):\1:' Makefile
}
