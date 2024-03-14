NEOTERM_PKG_HOMEPAGE=https://github.com/brailcom/speechd
NEOTERM_PKG_DESCRIPTION="Common interface to speech synthesis"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.11.5"
NEOTERM_PKG_SHA256=cc4b388fce40681eaff3545e9cc0642216c13c420d5676a4d28c957ddcb916de
NEOTERM_PKG_SRCURL=https://github.com/brailcom/speechd/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_DEPENDS="dotconf, espeak, glib, libiconv, libltdl, libsndfile, pulseaudio, python, speechd-data"
NEOTERM_PKG_BUILD_DEPENDS="libiconv-static, libsndfile-static"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SETUP_PYTHON=true

# Fails to find generated headers
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-pulse
--with-espeak-ng
"

# spd-conf needs python stuff, so remove for now
NEOTERM_PKG_RM_AFTER_INSTALL="bin/spd-conf"

# We cannot run cross-compiled programs to get help message, so disable
# man-page generation with help2man
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="ac_cv_prog_HELP2MAN="

neoterm_step_pre_configure() {
	export am_cv_python_pythondir="${NEOTERM_PREFIX}/lib/python${NEOTERM_PYTHON_VERSION}/site-packages"
	export am_cv_python_pyexecdir="$am_cv_python_pythondir"
	./build.sh
}

neoterm_step_post_massage() {
	find lib -name '*.la' -delete
}
