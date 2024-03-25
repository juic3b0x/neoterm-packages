NEOTERM_PKG_HOMEPAGE=https://github.com/pytorch/vision
NEOTERM_PKG_DESCRIPTION="Datasets, Transforms and Models specific to Computer Vision"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.15.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/pytorch/vision
# ffmpeg
NEOTERM_PKG_DEPENDS="libc++, python, python-numpy, python-pillow, python-pip, python-torch, libjpeg-turbo, libpng, zlib"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, setuptools"

neoterm_step_pre_configure() {
	CFLAGS+=" -I${NEOTERM_PYTHON_HOME}/site-packages/torch/include"
	CFLAGS+=" -I${NEOTERM_PYTHON_HOME}/site-packages/torch/include/torch/csrc/api/include"
	CXXFLAGS+=" -DUSE_PYTHON"
	LDFLAGS+=" -ltorch_cpu -ltorch_python -lc10"

	# FIXME: Disable ffmpeg temporarily because torchvision doesn't support ffmpeg 6.
	export TORCHVISION_USE_FFMPEG=0
	export BUILD_VERSION=$NEOTERM_PKG_VERSION
}

neoterm_step_configure() {
	:
}

neoterm_step_make_install() {
	pip -v install --no-build-isolation --no-deps --prefix "$NEOTERM_PREFIX" "$NEOTERM_PKG_SRCDIR"
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "pip3 install typing_extensions requests" >> postinst
}
