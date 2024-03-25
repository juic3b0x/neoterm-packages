NEOTERM_PKG_HOMEPAGE=https://www.codeblocks.org/
NEOTERM_PKG_DESCRIPTION="Code::Blocks is the Integrated Development Environment (IDE)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=20.03
NEOTERM_PKG_SRCURL=https://sourceforge.net/projects/codeblocks/files/Sources/${NEOTERM_PKG_VERSION}/codeblocks-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=15eeb3e28aea054e1f38b0c7f4671b4d4d1116fd05f63c07aa95a91db89eaac5
NEOTERM_PKG_DEPENDS="codeblocks-data, glib, gtk3, libc++, wxwidgets, zip"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-contrib-plugins --disable-compiler"

neoterm_step_post_get_source() {
	local f
	for f in $NEOTERM_PKG_BUILDER_DIR/backport-r*.diff; do
		local b=$(basename "${f}")
		echo "Applying ${b}"
		local d="$NEOTERM_PKG_BUILDER_DIR/${b#backport-}.diff"
		if [ -f "${d}" ]; then
			patch -d $NEOTERM_PKG_BUILDER_DIR -o - < "${d}" \
				| patch --silent -p0
		else
			patch --silent -p0 < "${f}"
		fi
	done
}

neoterm_step_host_build() {
	"${NEOTERM_PKG_SRCDIR}/configure"
	make -j $NEOTERM_MAKE_PROCESSES -C src/base
	make -j $NEOTERM_MAKE_PROCESSES -C src/build_tools
}

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

neoterm_step_post_configure() {
	cp -r $NEOTERM_PKG_HOSTBUILD_DIR/src/build_tools ./src
	sed -i 's/ -shared / -Wl,-O1,--as-needed\0/g' ./libtool
}
