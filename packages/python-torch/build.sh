NEOTERM_PKG_HOMEPAGE=https://pytorch.org/
NEOTERM_PKG_DESCRIPTION="Tensors and Dynamic neural networks in Python"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.1.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/pytorch/pytorch
NEOTERM_PKG_UPDATE_TAG_TYPE="latest-release-tag"
NEOTERM_PKG_DEPENDS="ffmpeg, libc++, libopenblas, libprotobuf, libzmq, opencv, python, python-numpy, python-pip, fmt"
NEOTERM_PKG_BUILD_DEPENDS="vulkan-headers, vulkan-loader-android"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, pyyaml, typing_extensions"
NEOTERM_PKG_PYTHON_BUILD_DEPS="numpy"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_NEOTERM=OFF
-DBUILD_CUSTOM_PROTOBUF=OFF
-DBUILD_PYTHON=ON
-DBUILD_TEST=OFF
-DCMAKE_BUILD_TYPE=Release
-DCMAKE_INSTALL_PREFIX=${NEOTERM_PKG_SRCDIR}/torch
-DCMAKE_PREFIX_PATH=${NEOTERM_PYTHON_HOME}/site-packages
-DNUMPY_INCLUDE_DIR=${NEOTERM_PYTHON_HOME}/site-packages/numpy/core/include
-DOpenBLAS_INCLUDE_DIR=${NEOTERM_PREFIX}/include/openblas
-DPYTHON_INCLUDE_DIR=${NEOTERM_PREFIX}/include/python${NEOTERM_PYTHON_VERSION}
-DPYTHON_LIBRARY=${NEOTERM_PREFIX}/lib/libpython${NEOTERM_PYTHON_VERSION}.so
-DNATIVE_BUILD_DIR=${NEOTERM_PKG_HOSTBUILD_DIR}
-DTORCH_BUILD_VERSION=${NEOTERM_PKG_VERSION}
-DONNX_USE_PROTOBUF_SHARED_LIBS=ON
-DUSE_NUMPY=ON
-DUSE_OPENCV=ON
-DUSE_FFMPEG=ON
-DUSE_ZMQ=ON
-DUSE_CUDA=OFF
-DUSE_FAKELOWP=OFF
-DUSE_FBGEMM=OFF
-DUSE_ITT=OFF
-DUSE_MAGMA=OFF
-DUSE_METAL=OFF
-DUSE_NCCL=OFF
-DUSE_NNPACK=OFF
-DCXX_AVX512_FOUND=OFF
-DCXX_AVX2_FOUND=OFF
-DUSE_VULKAN=ON
-DANDROID_NDK=${NDK}
-DANDROID_NDK_HOST_SYSTEM_NAME=linux-$HOSTTYPE
"

NEOTERM_PKG_RM_AFTER_INSTALL="
lib/pkgconfig
lib/cmake/fmt
lib/libfmt.a
"

neoterm_step_host_build() {
	neoterm_setup_cmake
	cmake "$NEOTERM_PKG_SRCDIR/third_party/sleef"
	make -j "$NEOTERM_MAKE_PROCESSES" mkrename mkrename_gnuabi mkmasked_gnuabi mkalias mkdisp
}

neoterm_step_pre_configure() {
	export PYTHONPATH="${PYTHONPATH}:${NEOTERM_PKG_SRCDIR}"
	find "$NEOTERM_PKG_SRCDIR" -name CMakeLists.txt -o -name '*.cmake' ! -name 'VulkanCodegen*' | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_NEOTERM\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_NEOTERM/g'

	neoterm_setup_protobuf

	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
	-DPYTHON_EXECUTABLE=$(command -v python3)
	-DPROTOBUF_PROTOC_EXECUTABLE=$(command -v protoc)
	-DCAFFE2_CUSTOM_PROTOC_EXECUTABLE=$(command -v protoc)
	"

	# /home/builder/.neoterm-build/python-torch/src/torch/csrc/jit/codegen/onednn/graph_helper.h:3:10: fatal error: 'oneapi/dnnl/dnnl_graph.hpp' file not found
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
	-DUSE_MKLDNN=OFF
	"

	ln -sf "$NEOTERM_PKG_BUILDDIR" build
}

neoterm_step_make_install() {
	export PYTORCH_BUILD_VERSION=${NEOTERM_PKG_VERSION}
	export PYTORCH_BUILD_NUMBER=0
	pip -v install --no-deps --no-build-isolation --prefix $NEOTERM_PREFIX "$NEOTERM_PKG_SRCDIR"
	ln -sr ${NEOTERM_PYTHON_HOME}/site-packages/torch/lib/*.so ${NEOTERM_PREFIX}/lib
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "echo 'Installing dependencies for $NEOTERM_PKG_NAME...'" >> postinst
	echo "pip3 install filelock jinja2 networkx sympy typing_extensions" >> postinst
}
