NEOTERM_PKG_HOMEPAGE=https://tox.chat
NEOTERM_PKG_DESCRIPTION="Backend library for the Tox protocol"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Match commit SHA with toxic/blob/master/script/build-minimal-static-toxic.sh
_COMMIT=c08409390fe185c8b65e218d5c36c9347234f3e7
_COMMIT_DATE=20240129
NEOTERM_PKG_VERSION=0.2.18-p${_COMMIT_DATE}
NEOTERM_PKG_SRCURL=git+https://github.com/TokTok/c-toxcore
NEOTERM_PKG_SHA256=f5ac9d1890e0442dd4963aec556fa49dca3aea58832e81d64439e7417561a11c
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libsodium, libopus, libvpx"
NEOTERM_PKG_BREAKS="c-toxcore-dev"
NEOTERM_PKG_REPLACES="c-toxcore-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBOOTSTRAP_DAEMON=off
-DDHT_BOOTSTRAP=off
"

neoterm_step_get_source() {
	rm -rf $NEOTERM_PKG_SRCDIR
	mkdir -p $NEOTERM_PKG_SRCDIR
	cd $NEOTERM_PKG_SRCDIR
	git clone --depth 1 --branch ${NEOTERM_PKG_GIT_BRANCH} \
		${NEOTERM_PKG_SRCURL#git+} .
	git fetch --unshallow
	git checkout $_COMMIT
	git submodule update --init --recursive --depth=1
}

neoterm_step_post_get_source() {
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

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local a
	for a in CURRENT AGE; do
		local _LT_${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' \
				so.version)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
