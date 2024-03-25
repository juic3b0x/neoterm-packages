NEOTERM_PKG_HOMEPAGE=https://developer.gnome.org/glib/
NEOTERM_PKG_DESCRIPTION="Library providing core building blocks for libraries and applications written in C"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.78.4"
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/gnome/sources/glib/${NEOTERM_PKG_VERSION%.*}/glib-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=24b8e0672dca120cc32d394bccb85844e732e04fe75d18bb0573b2dbc7548f63
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libffi, libiconv, pcre2, resolv-conf, zlib"
NEOTERM_PKG_BREAKS="glib-dev"
NEOTERM_PKG_REPLACES="glib-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Druntime_dir=$NEOTERM_PREFIX/var/run
-Dlibmount=disabled
"
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/glib-gettextize
bin/gtester-report
lib/locale
share/gdb/auto-load
share/glib-2.0/gdb
share/glib-2.0/gettext
share/gtk-doc
"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
-Ddefault_library=static
-Dlibmount=disabled
-Dtests=false
--prefix ${NEOTERM_PREFIX}/opt/${NEOTERM_PKG_NAME}/cross
"
NEOTERM_PKG_NO_SHEBANG_FIX_FILES="
opt/glib/cross/bin/gdbus-codegen
opt/glib/cross/bin/glib-genmarshal
opt/glib/cross/bin/glib-gettextize
opt/glib/cross/bin/glib-mkenums
opt/glib/cross/bin/gtester-report
"

neoterm_step_host_build() {
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "true" ]]; then return; fi

	# XXX: neoterm_setup_meson is not expected to be called in host build
	AR=;CC=;CFLAGS=;CPPFLAGS=;CXX=;CXXFLAGS=;LD=;LDFLAGS=;PKG_CONFIG=;STRIP=
	neoterm_setup_meson
	unset AR CC CFLAGS CPPFLAGS CXX CXXFLAGS LD LDFLAGS PKG_CONFIG STRIP

	${NEOTERM_MESON} ${NEOTERM_PKG_SRCDIR} . \
		${NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	ninja -j "${NEOTERM_MAKE_PROCESSES}" install

	# neoterm_step_massage strip does not cover opt dir
	find "${NEOTERM_PREFIX}/opt" \
		-path "*/glib/cross/bin/*" \
		-type f -print0 | \
		xargs -0 -r file | grep -E "ELF .+ (executable|shared object)" | \
		cut -d":" -f1 | xargs -r strip --strip-unneeded --preserve-dates
}

neoterm_step_pre_configure() {
	# glib checks for __BIONIC__ instead of __ANDROID__:
	CFLAGS+=" -D__BIONIC__=1"
}

neoterm_step_post_make_install() {
	local pc_files=$(ls "${NEOTERM_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig")
	for pc in ${pc_files}; do
		echo "INFO: Patching cross pkgconfig ${pc}"
		sed "s|\${bindir}|${NEOTERM_PREFIX}/opt/glib/cross/bin|g" \
			"${NEOTERM_PREFIX}/lib/pkgconfig/${pc}" \
			> "${NEOTERM_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig/${pc}"
	done
}

neoterm_step_create_debscripts() {
	for i in postinst postrm triggers; do
		sed \
			"s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
			"${NEOTERM_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	chmod 644 ./triggers
}
