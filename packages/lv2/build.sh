NEOTERM_PKG_HOMEPAGE=https://lv2plug.in/
NEOTERM_PKG_DESCRIPTION="A plugin standard for audio systems"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.18.10
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://lv2plug.in/spec/lv2-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=78c51bcf21b54e58bb6329accbb4dae03b2ed79b520f9a01e734bd9de530953f
NEOTERM_PKG_DEPENDS="libxml2, libxslt, python, sord, python-pip, python-lxml"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-Dplugins=disabled"
NEOTERM_PKG_PYTHON_TARGET_DEPS="pygments, rdflib"

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!$NEOTERM_PREFIX/bin/sh
		echo "Installing dependencies through pip..."
		pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
