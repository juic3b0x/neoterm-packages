NEOTERM_PKG_HOMEPAGE=https://bellard.org/tcc/
NEOTERM_PKG_DESCRIPTION="Tiny C Compiler"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=6a24b762d3e1086dcffd002c68cb5ca3a33a5c6d
_COMMIT_DATE=20230415
NEOTERM_PKG_VERSION=1:0.9.27-p${_COMMIT_DATE}
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://repo.or.cz/tinycc.git
NEOTERM_PKG_SHA256=467792219d0172f594ec71bcd6bac9dbb25308cbe9f708bab455b717148b491b
NEOTERM_PKG_GIT_BRANCH=mob
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local pdate="p$(git log -1 --format=%cs | sed 's/-//g')"
	if [[ "$NEOTERM_PKG_VERSION" != *"${pdate}" ]]; then
		echo -n "ERROR: The version string \"$NEOTERM_PKG_VERSION\" is"
		echo -n " different from what is expected to be; should end"
		echo " with \"${pdate}\"."
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_pre_configure() {
	cd $NEOTERM_PKG_BUILDDIR
	rm -rf _bin
	mkdir _bin
	cd _bin
	local _ar="$NEOTERM_HOST_PLATFORM-ar"
	cat > "${_ar}" <<-EOF
		#!$(command -v sh)
		exec $(command -v $AR) "\$@"
	EOF
	chmod 0700 "${_ar}"
	export PATH="$(pwd):$PATH"
}

neoterm_step_configure() {
	unset CFLAGS CXXFLAGS

	if [ "${NEOTERM_ARCH}" = "arm" ] || [ "${NEOTERM_ARCH}" = "i686" ]; then
		ELF_INTERPRETER_PATH="/system/bin/linker"
		ANDROID_LIB_PATH="/system/lib:/system/vendor/lib"
	else
		ELF_INTERPRETER_PATH="/system/bin/linker64"
		ANDROID_LIB_PATH="/system/lib64:/system/vendor/lib64"
	fi
}

neoterm_step_make() {
	(
		sysinc=
		otherinc=
		for d in $(echo | $CC -E -x c - -v 2>&1 | \
				sed -n '/^#include <...> search/,/^End/p' | \
				grep '^\s'); do
			p="$(readlink -f "${d}"):"
			if [[ "${d}" = */sysroot/usr/* ]]; then
				sysinc+="${p}"
			else
				otherinc+="${p}"
			fi
		done
		sysinc="${sysinc}${otherinc%:}"
		unset CC CFLAGS LDFLAGS
		./configure \
			--prefix="/tmp/tcc.host" \
			--cpu="${NEOTERM_ARCH}" \
			--sysincludepaths="${sysinc}"
		make -j $NEOTERM_MAKE_PROCESSES tcc
		mv -f tcc tcc.host
		make distclean
	)

	./configure \
		--prefix="$NEOTERM_PREFIX" \
		--cross-prefix="${CC//clang}" \
		--cc="clang" \
		--cpu="$NEOTERM_ARCH" \
		--disable-rpath \
		--elfinterp="$ELF_INTERPRETER_PATH" \
		--crtprefix="$NEOTERM_PREFIX/lib/tcc/crt" \
		--sysincludepaths="$NEOTERM_PREFIX/include/$NEOTERM_HOST_PLATFORM:$NEOTERM_PREFIX/include:$NEOTERM_PREFIX/lib/tcc/include" \
		--libpaths="$NEOTERM_PREFIX/lib:$NEOTERM_PREFIX/lib/tcc:$ANDROID_LIB_PATH"

	mv tcc.host tcc
	touch -d "next minute" tcc
	make -j ${NEOTERM_MAKE_PROCESSES} libtcc1.a

	rm -f tcc
	make -j ${NEOTERM_MAKE_PROCESSES} tcc
}

neoterm_step_post_make_install() {
	mkdir -p "${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}"/lib/tcc/crt
	for file in crtbegin_dynamic.o crtbegin_so.o crtend_android.o crtend_so.o; do
		install -Dm600 \
			"${NEOTERM_STANDALONE_TOOLCHAIN}/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM/$NEOTERM_PKG_API_LEVEL/$file" \
			"${NEOTERM_PREFIX}/lib/tcc/crt/$file"
	done
}
