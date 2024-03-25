NEOTERM_PKG_HOMEPAGE=https://firefox-source-docs.mozilla.org/security/nss/
NEOTERM_PKG_DESCRIPTION="Network Security Services (NSS)"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_LICENSE_FILE="nss/COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.95"
NEOTERM_PKG_SRCURL=https://archive.mozilla.org/pub/security/nss/releases/NSS_${NEOTERM_PKG_VERSION//./_}_RTM/src/nss-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=469888e41e8a780051ce00edcd914e8a6bd38da88a82cfb84898dd388635822a
NEOTERM_PKG_DEPENDS="libnspr, libsqlite"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
CC_IS_CLANG=1
CROSS_COMPILE=1
NSPR_INCLUDE_DIR=$NEOTERM_PREFIX/include/nspr
NSS_DISABLE_GTESTS=1
NSS_ENABLE_WERROR=0
NSS_SEED_ONLY_DEV_URANDOM=1
NSS_USE_SYSTEM_SQLITE=1
OS_TEST=$NEOTERM_ARCH
"
NEOTERM_MAKE_PROCESSES=1
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_NO_STATICSPLIT=true

_LIBNSS_SIGN_LIBS="libfreebl3.so libnssdbm3.so libsoftokn3.so"

neoterm_step_host_build() {
	mkdir -p nsinstall
	cd nsinstall
	for f in nsinstall.c pathsub.c; do 
		gcc -c $NEOTERM_PKG_SRCDIR/nss/coreconf/nsinstall/$f
	done
	gcc nsinstall.o pathsub.o -o nsinstall
}

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DANDROID"
	LDFLAGS+=" -llog"

	NEOTERM_PKG_EXTRA_MAKE_ARGS+=" NSINSTALL=$NEOTERM_PKG_HOSTBUILD_DIR/nsinstall/nsinstall"
	if [ $NEOTERM_ARCH_BITS -eq 64 ]; then
		NEOTERM_PKG_EXTRA_MAKE_ARGS+=" USE_64=1"
	fi
}

neoterm_step_make() {
	cd nss
	make -j $NEOTERM_MAKE_PROCESSES \
		CCC="$CXX" \
		XCFLAGS="$CFLAGS $CPPFLAGS" \
		CPPFLAGS="$CPPFLAGS" \
		${NEOTERM_PKG_EXTRA_MAKE_ARGS}
}

neoterm_step_make_install() {
	local pkgconfig_dir=$NEOTERM_PREFIX/lib/pkgconfig
	mkdir -p $pkgconfig_dir
	sed \
		-e "s|%prefix%|${NEOTERM_PREFIX}|g" \
		-e 's|%exec_prefix%|${prefix}|g' \
		-e 's|%libdir%|${prefix}/lib|g' \
		-e 's|%includedir%|${prefix}/include/nss|g' \
		-e "s|%NSS_VERSION%|${NEOTERM_PKG_VERSION#*:}|g" \
		-e 's|%NSPR_VERSION%|4.25|g' \
		nss/pkg/pkg-config/nss.pc.in > $pkgconfig_dir/nss.pc
	cd dist
	install -Dm600 -t $NEOTERM_PREFIX/include/nss public/nss/*
	install -Dm600 -t $NEOTERM_PREFIX/include/nss/private private/nss/*
	install -Dm600 -t $NEOTERM_PREFIX/include/dbm public/dbm/*
	install -Dm600 -t $NEOTERM_PREFIX/include/dbm/private private/dbm/*
	pushd *.OBJ
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/*
	install -Dm600 -t $NEOTERM_PREFIX/lib lib/*
	for f in $_LIBNSS_SIGN_LIBS; do
		if [ ! -e lib/$f ]; then
			echo "ERROR: \"lib/$f\" not found."
			exit 1
		fi
	done
	popd
}

neoterm_step_post_massage() {
	find lib -name '*.a' \
		-a ! -name libcrmf.a \
		-a ! -name libfreebl.a \
		-a ! -name libnssb.a \
		-a ! -name libnssckfw.a \
		-delete
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	for f in $_LIBNSS_SIGN_LIBS; do
		echo "$NEOTERM_PREFIX/bin/shlibsign -i $NEOTERM_PREFIX/lib/$f" >> postinst
	done
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
