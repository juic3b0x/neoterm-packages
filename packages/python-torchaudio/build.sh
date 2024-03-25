NEOTERM_PKG_HOMEPAGE=https://github.com/pytorch/audio
NEOTERM_PKG_DESCRIPTION="Data manipulation and transformation for audio signal processing, powered by PyTorch"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/pytorch/audio
# FFMPEG
NEOTERM_PKG_DEPENDS="libc++, python, python-pip, python-torch"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, setuptools"

neoterm_step_pre_configure() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	export BUILD_VERSION=$NEOTERM_PKG_VERSION
	# FIXME: The same as torchvision, upstream doesn't support ffmpeg 6.
	export USE_FFMPEG=0
	export TORCHAUDIO_CMAKE_PREFIX_PATH="$NEOTERM_PYTHON_HOME/site-packages/torch;$NEOTERM_PREFIX"
	export host_alias="$NEOTERM_HOST_PLATFORM"
}

neoterm_step_configure() {
	:
}

neoterm_step_make_install() {
	pip -v install --no-build-isolation --no-deps --prefix "$NEOTERM_PREFIX" "$NEOTERM_PKG_SRCDIR"
}
