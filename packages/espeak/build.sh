NEOTERM_PKG_HOMEPAGE=https://github.com/espeak-ng/espeak-ng
NEOTERM_PKG_DESCRIPTION="Compact software speech synthesizer"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Use eSpeak NG as the original eSpeak project is dead.
NEOTERM_PKG_VERSION="1.51"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://github.com/espeak-ng/espeak-ng/archive/${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=f0e028f695a8241c4fa90df7a8c8c5d68dcadbdbc91e758a97e594bbb0a3bdbf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, pcaudiolib"
NEOTERM_PKG_BREAKS="espeak-dev"
NEOTERM_PKG_REPLACES="espeak-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-async --with-pcaudiolib"

neoterm_step_post_get_source() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if ${NEOTERM_ON_DEVICE_BUILD}; then
		neoterm_error_exit "Package '${NEOTERM_PKG_NAME}' is not safe for on-device builds."
	fi

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local e=$(sed -En 's/^SHARED_VERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi

	./autogen.sh
}

neoterm_step_host_build() {
	cd "${NEOTERM_PKG_SRCDIR}" || exit 1
	./configure && make
	# Man pages require the ronn ruby program.
	#make src/espeak-ng.1
	#cp src/espeak-ng.1 $NEOTERM_PREFIX/share/man/man1
	#(cd $NEOTERM_PREFIX/share/man/man1 && ln -s -f espeak-ng.1 espeak.1)
}

neoterm_step_make() {
	make -B src/{e,}speak-ng
}

neoterm_step_pre_configure() {
	# Oz flag causes problems. See https://github.com/neoterm/neoterm-packages/issues/1680:
	CFLAGS=${CFLAGS/-Oz/-Os}
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

neoterm_step_make_install() {
	# Calling make install directly tends to build lang data files again but with cross compiled espeak-ng.
	# So use make install-data which will install the data files compiled with previously built espeak-ng
	# in host build step.
	make install-data install-exec
}
