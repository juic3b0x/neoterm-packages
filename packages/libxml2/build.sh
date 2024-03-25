NEOTERM_PKG_HOMEPAGE=http://www.xmlsoft.org
NEOTERM_PKG_DESCRIPTION="Library for parsing XML documents"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.12.5"
_MAJOR_VERSION="${NEOTERM_PKG_VERSION%.*}"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libxml2/${_MAJOR_VERSION}/libxml2-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=a972796696afd38073e0f59c283c3a2f5a560b5268b4babc391b286166526b21
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SETUP_PYTHON=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-python
"
NEOTERM_PKG_RM_AFTER_INSTALL="share/gtk-doc"
NEOTERM_PKG_DEPENDS="libiconv, liblzma, zlib"
NEOTERM_PKG_BREAKS="libxml2-dev"
NEOTERM_PKG_REPLACES="libxml2-dev"

neoterm_step_pre_configure() {
	# SOVERSION suffix is needed for SONAME of shared libs to avoid conflict
	# with system ones (in /system/lib64 or /system/lib):
	sed -i 's/^\(linux\*android\)\*)/\1-noneoterm)/' configure
}

neoterm_step_post_massage() {
	# Check if SONAME is properly set:
	if ! readelf -d lib/libxml2.so | grep -q '(SONAME).*\[libxml2\.so\.'; then
		neoterm_error_exit "SONAME for libxml2.so is not properly set."
	fi

	local _GUARD_FILE="lib/libxml2.so.2"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
