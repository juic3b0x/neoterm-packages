NEOTERM_PKG_HOMEPAGE=https://www.monetdb.org/
NEOTERM_PKG_DESCRIPTION="A high-performance database kernel for query-intensive applications"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="11.49.1"
NEOTERM_PKG_SRCURL=https://www.monetdb.org/downloads/sources/archive/MonetDB-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=f112ee377ae0d00c29e277b4e57e8140f57d33a41c03b5b4ede3c31384212cef
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-sysv-semaphore, libbz2, libcurl, libiconv, liblz4, liblzma, libxml2, netcdf-c, pcre, readline, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DODBC=OFF
-DTESTING=OFF
"

# ```
# In file included from [...]/src/common/stream/stream.c:58:
# In file included from [...]/src/common/stream/stream_internal.h:19:
# [...]/src/common/utils/matomic.h:90:2: error: "we need _Atomic(unsigned long long) to be lock free"
# #error "we need _Atomic(unsigned long long) to be lock free"
#  ^
# ```
NEOTERM_PKG_BLACKLISTED_ARCHES="i686"

neoterm_step_post_get_source() {
	find . -name '*.c' | xargs -n 1 sed -i \
		-e 's:"\(/tmp\):"'$NEOTERM_PREFIX'\1:g'
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-sysv-semaphore -lm"
}
