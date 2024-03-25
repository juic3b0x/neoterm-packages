NEOTERM_PKG_HOMEPAGE=https://www.7-zip.org
NEOTERM_PKG_DESCRIPTION="7-Zip file archiver with a high compression ratio"
NEOTERM_PKG_LICENSE="LGPL-2.1, BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=23.01
NEOTERM_PKG_SRCURL=https://www.7-zip.org/a/7z${NEOTERM_PKG_VERSION//./}-src.tar.xz
NEOTERM_PKG_SHA256=356071007360e5a1824d9904993e8b2480b51b570e8c9faf7c0f58ebe4bf9f74
NEOTERM_PKG_BUILD_IN_SRC=true

# The original "neoterm_extract_src_archive" always strips the first components
# but the source of 7zip is directly under the root directory of the tar file
neoterm_extract_src_archive() {
	local file="$NEOTERM_PKG_CACHEDIR/$(basename "$NEOTERM_PKG_SRCURL")"
	mkdir -p "$NEOTERM_PKG_SRCDIR"
	tar -xf "$file" -C "$NEOTERM_PKG_SRCDIR"
}

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = 'aarch64' ]; then
		CFLAGS+=' -march=armv8.1-a+crypto'
		CXXFLAGS+=' -march=armv8.1-a+crypto'
	fi
	# from https://build.opensuse.org/package/view_file/openSUSE:Factory/7zip/7zip.spec?rev=5
	# Remove carriage returns from docs
	sed -i -e 's/\r$//g' DOC/*.txt
	# Remove executable perms from docs
	chmod -x DOC/*.txt
	# Remove -Werror to make build succeed
	sed -i -e 's/-Werror//' CPP/7zip/7zip_gcc.mak
}

neoterm_step_make() {
	# from https://git.alpinelinux.org/aports/tree/community/7zip/APKBUILD?id=b4601c88f608662c75422311b7ca3c26fab4b1f4
	cd CPP/7zip/Bundles/Alone2
	mkdir -p b/c
	# TODO: enable asm
	# DISABLE_RAR: RAR codec is non-free
	# -D_GNU_SOURCE: broken sched.h defines
	make \
		CC="$CC $CFLAGS $LDFLAGS -D_GNU_SOURCE" \
		CXX="$CXX $CXXFLAGS $LDFLAGS -D_GNU_SOURCE" \
		DISABLE_RAR=1 \
		--file ../../cmpl_clang.mak \
		--jobs "$NEOTERM_MAKE_PROCESSES"
}

neoterm_step_make_install() {
	install -Dm0755 \
		-t "$NEOTERM_PREFIX"/bin \
		"$NEOTERM_PKG_BUILDDIR"/CPP/7zip/Bundles/Alone2/b/c/7zz
	install -Dm0644 \
		-t "$NEOTERM_PREFIX"/share/doc/"$NEOTERM_PKG_NAME" \
		"$NEOTERM_PKG_BUILDDIR"/DOC/{7zC,7zFormat,lzma,Methods,readme,src-history}.txt
	install -Dm0644 \
		-t "$NEOTERM_PREFIX"/share/LICENSES/"$NEOTERM_PKG_NAME" \
		"$NEOTERM_PKG_BUILDDIR"/DOC/{copying,License}.txt
}
