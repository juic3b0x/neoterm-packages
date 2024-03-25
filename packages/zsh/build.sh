NEOTERM_PKG_HOMEPAGE=https://www.zsh.org
NEOTERM_PKG_DESCRIPTION="Shell with lots of features"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.9
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL="https://sourceforge.net/projects/zsh/files/zsh/$NEOTERM_PKG_VERSION/zsh-$NEOTERM_PKG_VERSION".tar.xz
NEOTERM_PKG_SHA256=9b8d1ecedd5b5e81fbf1918e876752a7dd948e05c1a0dba10ab863842d45acd5
# Remove hard link to bin/zsh as Android does not support hard links:
NEOTERM_PKG_RM_AFTER_INSTALL="bin/zsh-${NEOTERM_PKG_VERSION}"
NEOTERM_PKG_DEPENDS="libandroid-support, libcap, ncurses, neoterm-tools, command-not-found, pcre"
NEOTERM_PKG_RECOMMENDS="command-not-found, zsh-completions"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gdbm
--enable-pcre
--enable-cap
--enable-etcdir=$NEOTERM_PREFIX/etc
zsh_cv_path_wtmp=no
ac_cv_header_utmp_h=no
ac_cv_func_getpwuid=yes
ac_cv_func_setresgid=no
ac_cv_func_setresuid=no
"
NEOTERM_PKG_CONFFILES="etc/zshrc"
NEOTERM_PKG_BUILD_IN_SRC=true

# Remove compdef pkg not suitable for NeoTerm:
NEOTERM_PKG_RM_AFTER_INSTALL+="
share/zsh/${NEOTERM_PKG_VERSION}/functions/_pkg5
"

neoterm_step_pre_configure() {

	## fix "largefile" for arithmetic larger than sint32
	## as zsh force disable the detection of these flags in its ./configure when running in a cross-build environment
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
	zsh_cv_printf_has_lld=yes
	zsh_cv_rlim_t_is_longer=no
	zsh_cv_type_rlim_t_is_unsigned=yes
	"
	if [[ "$NEOTERM_ARCH" = arm || "$NEOTERM_ARCH" = i686 ]] ; then
		## this essentially attempts to add zsh_cv_64_bit_type="long long" in EXTRA_CONFIGURE_ARGS.
		## the space in argument to this flag make build script of neoterm
		## wrongly splitted the flag as separated flags
		## the reason is neoterm build script does not use ${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS[@]}
		## (which is required to keep space in each flags by using an array) during shell expansion
		perl -0pe 's#zsh_cv_64_bit_type=no#zsh_cv_64_bit_type="long long"#ms' < configure > configure.newf
		cat configure.newf > configure
		rm configure.newf

		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
		zsh_cv_off_t_is_64_bit=yes
		"
	else
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
		zsh_cv_64_bit_type=long
		"
	fi

}

neoterm_step_post_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# INSTALL file: "For a non-dynamic zsh, the default is to compile the complete, compctl, zle,
	# computil, complist, sched, # parameter, zleparameter and rlimits modules into the shell,
	# and you will need to edit config.modules to make any other modules available."
	# Since we build zsh non-dynamically (since dynamic loading doesn't work on Android when enabled),
	# we need to explicitly enable the additional modules we want.
	# - The files module is needed by `compinstall` (https://github.com/neoterm/neoterm-packages/issues/61).
	# - The regex module seems to be used by several extensions.
	# - The curses, socket and zprof modules was desired by BrainDamage on IRC (#neoterm).
	# - The deltochar and mathfunc modules is used by grml-zshrc (https://github.com/neoterm/neoterm-packages/issues/494).
	# - The system module is needed by zplug (https://github.com/neoterm/neoterm-packages/issues/659).
	# - The zpty module is needed by zsh-async (https://github.com/neoterm/neoterm-packages/issues/672).
	# - The stat module is needed by zui (https://github.com/neoterm/neoterm-packages/issues/2829).
	# - The mapfile module was requested in https://github.com/neoterm/neoterm-packages/issues/3116.
	# - The zselect module is used by multiple plugins (https://github.com/neoterm/neoterm-packages/issues/4939)
	# - The param_private module was requested in https://github.com/neoterm/neoterm-packages/issues/7391.
	# - The cap module was requested in https://github.com/neoterm/neoterm-packages/issues/3102.
	for module in cap curses deltochar files mapfile mathfunc pcre regex \
		socket stat system zprof zpty zselect param_private
	do
		perl -p -i -e "s|${module}.mdd link=no|${module}.mdd link=static|" $NEOTERM_PKG_BUILDDIR/config.modules
	done
}

neoterm_step_post_make_install() {
	# /etc/zshrc - Run for interactive shells (http://zsh.sourceforge.net/Guide/zshguide02.html):
	sed "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" $NEOTERM_PKG_BUILDER_DIR/etc-zshrc > $NEOTERM_PREFIX/etc/zshrc

	# Remove zsh.new/zsh.old/zsh-$version if any exists:
	rm -f $NEOTERM_PREFIX/{zsh-*,zsh.*}
}
