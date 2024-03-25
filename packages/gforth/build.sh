NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gforth/
NEOTERM_PKG_DESCRIPTION="The Forth implementation of the GNU project"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/gforth/gforth-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2f62f2233bf022c23d01c920b1556aa13eab168e3236b13352ac5e9f18542bb0
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file___arch_386_asm_fs=yes
ac_cv_file___arch_386_disasm_fs=yes
ac_cv_file___arch_amd64_asm_fs=yes
ac_cv_file___arch_amd64_disasm_fs=yes
ac_cv_file___arch_arm_asm_fs=no
ac_cv_file___arch_arm_disasm_fs=no
ac_cv_file___arch_generic_asm_fs=no
ac_cv_file___arch_generic_disasm_fs=no
ac_cv_func_memcmp_working=yes
skipcode=no
--without-check
"
NEOTERM_MAKE_PROCESSES=1
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	find $NEOTERM_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;
	./configure --prefix=$_PREFIX_FOR_BUILD CC="gcc -m$NEOTERM_ARCH_BITS"
	make -j $NEOTERM_MAKE_PROCESSES
	make install
}

neoterm_step_pre_configure() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	PATH=$_PREFIX_FOR_BUILD/bin:$PATH
}

neoterm_step_post_configure() {
	sed -i -e 's:\.\(/gforth-ditc\):'$NEOTERM_PKG_HOSTBUILD_DIR'\1:g' \
		Makefile
}

neoterm_step_post_massage() {
	# Alignment of magic can be broken by shebang fix:
	# https://github.com/neoterm/neoterm-packages/issues/14648
	local f
	for f in $(find ./lib/gforth ./share/gforth -type f -name '*.fi'); do
		if [ $(head -c 2 "${f}") != '#!' ]; then
			continue
		fi
		local c1=$(head -n 1 "${f}" | wc -c)
		local c2=$(tail -c +$((c1+1)) "${f}" | head -c 16 | \
				sed -n 's/Gforth3.*//p' | wc -c)
		local p=$(( (8-(c1+c2)%8)%8 ))
		if [ ${p} -ne 0 ]; then
			echo "Fixing alignment of magic in ${f}"
			head -c ${c1} "${f}" > "${f}".new
			local i
			for i in $(seq ${p}); do
				echo -n " " >> "${f}".new
			done
			tail -c +$((c1+1)) "${f}" >> "${f}".new
			rm -f "${f}"
			mv "${f}".new "${f}"
		fi
	done
}
