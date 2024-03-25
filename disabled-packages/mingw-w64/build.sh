NEOTERM_PKG_HOMEPAGE=https://github.com/neoterm/neoterm-packages
NEOTERM_PKG_DESCRIPTION="MinGW-w64 toolchain (metapackage)"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_DEPENDS="clang, mingw-w64-crt, mingw-w64-gcc-libs"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	mkdir -p ${NEOTERM_PREFIX}/bin
	local arch
	for arch in x86_64 i686; do
		local target="${arch}-w64-mingw32"
		local sysroot="${NEOTERM_PREFIX}/${target}"
		local clang_opts="--start-no-unused-arguments"
		clang_opts+=" --target=${target}"
		clang_opts+=" --sysroot=${sysroot}"
		clang_opts+=" -fuse-ld=lld"
		clang_opts+=" -rtlib=libgcc"
		local clangxx_opts="${clang_opts} -stdlib=libstdc++"
		clang_opts+=" --end-no-unused-arguments"
		clangxx_opts+=" --end-no-unused-arguments"
		cat > ${NEOTERM_PREFIX}/bin/${target}-clang <<-EOF
			#!${NEOTERM_PREFIX}/bin/sh
			exec clang ${clang_opts} "\$@"
		EOF
		chmod 0700 ${NEOTERM_PREFIX}/bin/${target}-clang
		cat > ${NEOTERM_PREFIX}/bin/${target}-clang++ <<-EOF
			#!${NEOTERM_PREFIX}/bin/sh
			exec clang++ ${clangxx_opts} "\$@"
		EOF
		chmod 0700 ${NEOTERM_PREFIX}/bin/${target}-clang++
	done
}
