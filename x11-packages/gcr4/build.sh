NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gcr
NEOTERM_PKG_DESCRIPTION="A library for displaying certificates and crypto UI, accessing key stores"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.1
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gcr/${_MAJOR_VERSION}/gcr-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=9ceaad29284ba919b9216e2888c18ec67240c2c93b3a4856bc5488bbc1f3a383
NEOTERM_PKG_DEPENDS="glib, libgcrypt, p11-kit"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, gnupg"
NEOTERM_PKG_RECOMMENDS="gnupg"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
-Dgtk4=false
-Dgtk_doc=false
-Dgpg_path=$NEOTERM_PREFIX/bin/gpg
-Dssh_agent=false
-Dsystemd=disabled
"

neoterm_step_pre_configure() {
	neoterm_setup_gir

	local bin_dir=$NEOTERM_PKG_BUILDDIR/_dummy/bin
	mkdir -p $bin_dir
	pushd $bin_dir
	local p
	for p in ssh-add ssh-agent; do
		cat <<-EOF > $p
			#!$(command -v sh)
			exit 0
			EOF
		chmod 0700 $p
	done
	popd
	export PATH+=":$bin_dir"
}

neoterm_step_post_massage() {
	local _GUARD_FILES="lib/libgcr-4.so lib/libgck-2.so"
	local f
	for f in ${_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "Error: file ${f} not found."
		fi
	done
}
