NEOTERM_PKG_HOMEPAGE=https://opencv.org/
NEOTERM_PKG_DESCRIPTION="Open Source Computer Vision Library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.9.0"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SRCURL=https://github.com/opencv/opencv/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ddf76f9dffd322c7c3cb1f721d0887f62d747b82059342213138dc190f28bc6c
NEOTERM_PKG_DEPENDS="abseil-cpp, ffmpeg, libc++, libjpeg-turbo, libopenblas, libpng, libtiff, libwebp, openjpeg, openjpeg-tools, zlib"
# For static libprotobuf see
# https://github.com/neoterm/neoterm-packages/issues/16979
NEOTERM_PKG_BUILD_DEPENDS="libutf8-range, protobuf-static, python-numpy-static"
NEOTERM_PKG_PYTHON_COMMON_DEPS="Cython, wheel"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_NEOTERM=OFF
-DWITH_GSTREAMER=OFF
-DWITH_OPENEXR=OFF
-DBUILD_PROTOBUF=OFF
-DPROTOBUF_UPDATE_FILES=ON
-DOPENCV_GENERATE_PKGCONFIG=ON
-DOPENCV_SKIP_CMAKE_CXX_STANDARD=ON
"

neoterm_step_pre_configure() {
	neoterm_setup_protobuf
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DProtobuf_PROTOC_EXECUTABLE=$(command -v protoc)"
	sed -i 's/COMMAND\sprotobuf::protoc/COMMAND ${Protobuf_PROTOC_EXECUTABLE}/g' $NEOTERM_PREFIX/lib/cmake/protobuf/protobuf-generate.cmake

	CXXFLAGS+=" -std=c++14"
	LDFLAGS+=" -lutf8_range -lutf8_validity"
	LDFLAGS+=" $($NEOTERM_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
	LDFLAGS+=" -llog"

	find "$NEOTERM_PKG_SRCDIR" -name CMakeLists.txt -o -name '*.cmake' | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_NEOTERM\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_NEOTERM/g'

	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
		-DPYTHON_DEFAULT_EXECUTABLE=python
		-DPYTHON3_INCLUDE_PATH=$NEOTERM_PREFIX/include/python${NEOTERM_PYTHON_VERSION}
		-DPYTHON3_NUMPY_INCLUDE_DIRS=$NEOTERM_PYTHON_HOME/site-packages/numpy/core/include
		"

	mv $NEOTERM_PREFIX/lib/libprotobuf.so{,.tmp}
}

neoterm_step_post_make_install() {
	mv $NEOTERM_PREFIX/lib/libprotobuf.so{.tmp,}
}

neoterm_step_post_massage() {
	rm -rf lib/libprotobuf.so lib/cmake/protobuf/
}
