NEOTERM_PKG_HOMEPAGE=https://elinux.org/Android_aapt
NEOTERM_PKG_DESCRIPTION="Android Asset Packaging Tool"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_TAG_VERSION=13.0.0
_TAG_REVISION=6
NEOTERM_PKG_VERSION=${_TAG_VERSION}.${_TAG_REVISION}
NEOTERM_PKG_REVISION=10
NEOTERM_PKG_SRCURL=(https://android.googlesource.com/platform/frameworks/base
                   https://android.googlesource.com/platform/system/core
                   https://android.googlesource.com/platform/system/libbase
                   https://android.googlesource.com/platform/system/libziparchive
                   https://android.googlesource.com/platform/system/logging
                   https://android.googlesource.com/platform/system/incremental_delivery
                   https://android.googlesource.com/platform/build
                   https://android.googlesource.com/platform/system/tools/aidl)
NEOTERM_PKG_GIT_BRANCH=android-${_TAG_VERSION}_r${_TAG_REVISION}
NEOTERM_PKG_SHA256=(SKIP_CHECKSUM
                   SKIP_CHECKSUM
                   SKIP_CHECKSUM
                   SKIP_CHECKSUM
                   SKIP_CHECKSUM
                   SKIP_CHECKSUM
                   SKIP_CHECKSUM
                   SKIP_CHECKSUM)
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="libc++, libexpat, libpng, libzopfli, zlib"
NEOTERM_PKG_BUILD_DEPENDS="fmt, googletest"

neoterm_step_post_get_source() {
	# FIXME: We would like to enable checksums when downloading
	# tar files, but they change each time as the tar metadata
	# differs: https://github.com/google/gitiles/issues/84

	for i in $(seq 0 $(( ${#NEOTERM_PKG_SRCURL[@]}-1 ))); do
		git clone --depth 1 --single-branch \
			--branch $NEOTERM_PKG_GIT_BRANCH \
			${NEOTERM_PKG_SRCURL[$i]}
	done

	for f in base/tools/aapt2/*.proto; do
		sed -i 's:frameworks/base/tools/aapt2/::' $f
	done

	# Get zopfli source:
	local ZOPFLI_VER=$(bash -c ". $NEOTERM_SCRIPTDIR/packages/libzopfli/build.sh; echo \$NEOTERM_PKG_VERSION")
	local ZOPFLI_SHA256=$(bash -c ". $NEOTERM_SCRIPTDIR/packages/libzopfli/build.sh; echo \$NEOTERM_PKG_SHA256")
	local ZOPFLI_TARFILE=$NEOTERM_PKG_CACHEDIR/zopfli-${ZOPFLI_VER}.tar.gz
	neoterm_download \
		"https://github.com/google/zopfli/archive/zopfli-${ZOPFLI_VER}.tar.gz" \
		$ZOPFLI_TARFILE \
		$ZOPFLI_SHA256
	tar xf $ZOPFLI_TARFILE
	mv zopfli-zopfli-$ZOPFLI_VER zopfli
}

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	neoterm_setup_protobuf

	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR/_prefix/bin:$PATH

	CFLAGS+=" -fPIC"
	CXXFLAGS+=" -fPIC -std=c++17"
	CPPFLAGS+=" -DNDEBUG -D__ANDROID_SDK_VERSION__=__ANDROID_API__"
	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"

	_TMP_LIBDIR=$NEOTERM_PKG_SRCDIR/_lib
	rm -rf $_TMP_LIBDIR
	mkdir -p $_TMP_LIBDIR
	_TMP_BINDIR=$NEOTERM_PKG_SRCDIR/_bin
	rm -rf $_TMP_BINDIR
	mkdir -p $_TMP_BINDIR

	LDFLAGS+=" -llog -L$_TMP_LIBDIR"
}

neoterm_step_make() {
	. $NEOTERM_PKG_BUILDER_DIR/sources.sh

	local CORE_INCDIR=$NEOTERM_PKG_SRCDIR/core/include
	local LIBLOG_INCDIR=$NEOTERM_PKG_SRCDIR/logging/liblog/include
	local LIBBASE_SRCDIR=$NEOTERM_PKG_SRCDIR/libbase
	local LIBCUTILS_SRCDIR=$NEOTERM_PKG_SRCDIR/core/libcutils
	local LIBUTILS_SRCDIR=$NEOTERM_PKG_SRCDIR/core/libutils
	local INCFS_SUPPORT_INCDIR=$NEOTERM_PKG_SRCDIR/libziparchive/incfs_support/include
	local LIBZIPARCHIVE_SRCDIR=$NEOTERM_PKG_SRCDIR/libziparchive
	local INCFS_UTIL_SRCDIR=$NEOTERM_PKG_SRCDIR/incremental_delivery/incfs/util
	local ANDROIDFW_SRCDIR=$NEOTERM_PKG_SRCDIR/base/libs/androidfw
	local AAPT_SRCDIR=$NEOTERM_PKG_SRCDIR/base/tools/aapt
	local LIBIDMAP2_POLICIES_INCDIR=$NEOTERM_PKG_SRCDIR/base/cmds/idmap2/libidmap2_policies/include
	local AAPT2_SRCDIR=$NEOTERM_PKG_SRCDIR/base/tools/aapt2
	local ZIPALIGN_SRCDIR=$NEOTERM_PKG_SRCDIR/build/tools/zipalign
	local AIDL_SRCDIR=$NEOTERM_PKG_SRCDIR/aidl

	CPPFLAGS+=" -I. -I./include
		-I$LIBBASE_SRCDIR/include
		-I$LIBLOG_INCDIR
		-I$CORE_INCDIR"

	# Build libbase:
	cd $LIBBASE_SRCDIR
	for f in $libbase_sources; do
		$CXX $CXXFLAGS $CPPFLAGS $f -c
	done
	$CXX $CXXFLAGS *.o -shared $LDFLAGS \
		-o $_TMP_LIBDIR/libandroid-base.so

	# Build libcutils:
	cd $LIBCUTILS_SRCDIR
	for f in $libcutils_sources; do
		$CXX $CXXFLAGS $CPPFLAGS $f -c
	done
	$CXX $CXXFLAGS *.o -shared $LDFLAGS \
		-landroid-base \
		-o $_TMP_LIBDIR/libandroid-cutils.so

	# Build libutils:
	cd $LIBUTILS_SRCDIR
	for f in $libutils_sources; do
		$CXX $CXXFLAGS $CPPFLAGS $f -c
	done
	$CXX $CXXFLAGS *.o -shared $LDFLAGS \
		-landroid-base \
		-landroid-cutils \
		-o $_TMP_LIBDIR/libandroid-utils.so


	# Build libziparchive:
	cd $LIBZIPARCHIVE_SRCDIR
	for f in $libziparchive_sources; do
		$CXX $CXXFLAGS -std=c++20 $CPPFLAGS -I$INCFS_SUPPORT_INCDIR $f -c
	done
	$CXX $CXXFLAGS *.o -shared $LDFLAGS \
		-landroid-base \
		-lz \
		-o $_TMP_LIBDIR/libandroid-ziparchive.so

	CPPFLAGS+=" -I$LIBZIPARCHIVE_SRCDIR/include"

	CPPFLAGS+=" -I$INCFS_UTIL_SRCDIR/include"

	# Build libandroidfw:
	cd $ANDROIDFW_SRCDIR
	for f in $androidfw_sources $INCFS_UTIL_SRCDIR/map_ptr.cpp; do
		$CXX $CXXFLAGS $CPPFLAGS $f -c
	done
	$CXX $CXXFLAGS *.o -shared $LDFLAGS \
		-landroid-base \
		-landroid-cutils \
		-landroid-utils \
		-landroid-ziparchive \
		-lz \
		-o $_TMP_LIBDIR/libandroid-fw.so

	CPPFLAGS+=" -I$ANDROIDFW_SRCDIR/include"

	# Build aapt:
	cd $AAPT_SRCDIR
	for f in *.cpp; do
		$CXX $CXXFLAGS $CPPFLAGS $f -c
	done
	$CXX $CXXFLAGS *.o $LDFLAGS \
		-landroid-fw \
		-landroid-utils \
		-lexpat \
		-lpng \
		-lz \
		-o $_TMP_BINDIR/aapt

	# Build aapt2:
	cd $AAPT2_SRCDIR
	for f in $libaapt2_proto; do
		protoc --cpp_out=. $f
	done
	for f in $aapt2_sources; do
		$CXX $CXXFLAGS $CPPFLAGS -I$LIBIDMAP2_POLICIES_INCDIR \
			$f -c -o ${f%.*}.o
	done
	$CXX $CXXFLAGS $(find . -name '*.o') $LDFLAGS \
		-landroid-base \
		-landroid-fw \
		-landroid-utils \
		-landroid-ziparchive \
		-lexpat \
		-lpng \
		-lprotobuf \
		$($NEOTERM_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh) \
		-o $_TMP_BINDIR/aapt2

	# Build zipalign:
	cd $ZIPALIGN_SRCDIR
	for f in *.cpp; do
		$CXX $CXXFLAGS $CPPFLAGS -I$NEOTERM_PKG_SRCDIR/zopfli/src $f -c
	done
	$CXX $CXXFLAGS *.o $LDFLAGS \
		-landroid-utils \
		-landroid-ziparchive \
		-lzopfli \
		-lz \
		-o $_TMP_BINDIR/zipalign

	# Build aidl:
	cd $AIDL_SRCDIR
	flex aidl_language_l.ll
	bison --header=aidl_language_y.h aidl_language_y.yy
	cat >> aidl_language_y.h <<-EOF
		typedef union yy::parser::value_type YYSTYPE;
		typedef yy::parser::location_type YYLTYPE;
	EOF
	for f in $aidl_sources; do
		$CXX $CXXFLAGS $CPPFLAGS $f -c
	done
	$CXX $CXXFLAGS *.o $LDFLAGS \
		-landroid-base \
		-lfmt \
		-lgtest \
		-o $_TMP_BINDIR/aidl
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/lib \
		$_TMP_LIBDIR/libandroid-{cutils,utils,base,ziparchive,fw}.so
	install -Dm700 -t $NEOTERM_PREFIX/bin \
		$_TMP_BINDIR/{aapt,aapt2,zipalign,aidl}

	# Create an android.jar with AndroidManifest.xml and resources.arsc:
	cd $NEOTERM_PKG_TMPDIR
	rm -rf android-jar
	mkdir android-jar
	cd android-jar
	cp $ANDROID_HOME/platforms/android-33/android.jar .
	unzip -q android.jar
	mkdir -p $NEOTERM_PREFIX/share/aapt
	jar cfM $NEOTERM_PREFIX/share/aapt/android.jar AndroidManifest.xml resources.arsc
}
