NEOTERM_PKG_HOMEPAGE=https://android.googlesource.com/platform/ndk/
NEOTERM_PKG_DESCRIPTION="Thread debugging library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=22 # removed in NDK r23
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://android.googlesource.com/platform/ndk/+archive/refs/tags/ndk-r${NEOTERM_PKG_VERSION}/sources/android/libthread_db.tar.gz
NEOTERM_PKG_SHA256=SKIP_CHECKSUM
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_extract_src_archive() {
	local file="$NEOTERM_PKG_CACHEDIR/$(basename "${NEOTERM_PKG_SRCURL}")"
	mkdir -p "$NEOTERM_PKG_SRCDIR"
	tar xf "$file" -C "$NEOTERM_PKG_SRCDIR" libthread_db.c thread_db.h
}

neoterm_step_post_get_source() {
	sha256sum -c $NEOTERM_PKG_BUILDER_DIR/src.sha256sum
	cp $NEOTERM_PKG_BUILDER_DIR/td_init.c ./
}

neoterm_step_make() {
	$CC $CPPFLAGS -I. $CFLAGS libthread_db.c td_init.c \
		-shared -o libthread_db.so $LDFLAGS
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/include "$NEOTERM_PKG_SRCDIR/thread_db.h"
	install -Dm600 -t $NEOTERM_PREFIX/lib "$NEOTERM_PKG_BUILDDIR/libthread_db.so"
	ln -sf libthread_db.so $NEOTERM_PREFIX/lib/libthread_db.so.1
}
