NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gcr
NEOTERM_PKG_DESCRIPTION="A library for displaying certificates and crypto UI, accessing key stores"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# This specific package is for libgcr-3.
_MAJOR_VERSION=3.41
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gcr/${_MAJOR_VERSION}/gcr-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=bb7128a3c2febbfee9c03b90d77d498d0ceb237b0789802d60185c71c4bea24f
NEOTERM_PKG_DEPENDS="glib, gtk3, libcairo, libgcrypt, p11-kit, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, gnupg"
NEOTERM_PKG_RECOMMENDS="gnupg"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
-Dgtk=true
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
	local _GUARD_FILES="lib/libgcr-3.so lib/libgck-1.so"
	local f
	for f in ${_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "Error: file ${f} not found."
		fi
	done
}
