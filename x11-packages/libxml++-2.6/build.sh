NEOTERM_PKG_HOMEPAGE=https://libxmlplusplus.github.io/libxmlplusplus/
NEOTERM_PKG_DESCRIPTION="A C++ wrapper for the libxml2 XML parser library"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.42
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libxml++/${_MAJOR_VERSION}/libxml++-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=a433987f54cc1ecaa84af26af047a62df9e884574e0d686e5ddc6f70441c152b
NEOTERM_PKG_DEPENDS="libc++, libglibmm-2.4, libxml2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dvalidation=false
-Dbuild-examples=false
-Dbuild-tests=false
-Dmsvc14x-parallel-installable=false
"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
