NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Orca
NEOTERM_PKG_DESCRIPTION="A free, open source, flexible, and extensible screen reader"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=44
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/orca/${_MAJOR_VERSION}/orca-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=f5ed6551d72f897b21248d433085a7b817accbb0296a84c3e851d91fb2eee4de
NEOTERM_PKG_DEPENDS="at-spi2-core, glib, gst-python, gstreamer, gtk3, libwnck, pango, pyatspi, pygobject, python, python-pip, speechd"
NEOTERM_PKG_SETUP_PYTHON=true
NEOTERM_PKG_PYTHON_TARGET_DEPS="setproctitle"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
py_cv_mod_gi_=yes
py_cv_mod_json_=yes
py_cv_mod_speechd_=yes
py_cv_mod_brlapi_=no
py_cv_mod_louis_=no
"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		local _bin="$NEOTERM_PKG_BUILDDIR/_bin"
		export ITSTOOL="${_bin}/itstool"
		rm -rf "${_bin}"
		mkdir -p "${_bin}"
		cat > "$ITSTOOL" <<-EOF
			#!$(command -v sh)
			unset PYTHONPATH
			exec $(command -v itstool) "\$@"
		EOF
		chmod 0700 "$ITSTOOL"
	fi
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install $NEOTERM_PKG_PYTHON_TARGET_DEPS
	EOF
}
