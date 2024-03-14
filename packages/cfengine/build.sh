NEOTERM_PKG_HOMEPAGE=https://cfengine.com/
NEOTERM_PKG_DESCRIPTION="CFEngine is a configuration management technology"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@craigcomstock"
NEOTERM_PKG_VERSION=1:3.23.0
NEOTERM_PKG_SRCURL=git+https://github.com/cfengine/core
NEOTERM_PKG_SHA256=6d0b827d396a6e5ddefce8c12f80ec764ecc3ea70633f0c8524d06e0ae5ffbfc
# "-build[n]" suffix in tag name is not a part of version string.
_CFENGINE_GIT_TAG_SUFFIX=
NEOTERM_PKG_GIT_BRANCH=${NEOTERM_PKG_VERSION#*:}${_CFENGINE_GIT_TAG_SUFFIX}
NEOTERM_PKG_DEPENDS="libandroid-glob, liblmdb, libxml2, libyaml, openssl, pcre"
# core doesn't work with out-of-tree builds
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-workdir=$NEOTERM_PREFIX/var/lib/cfengine
--without-pam
--without-selinux-policy
--without-systemd-service
--with-lmdb=$NEOTERM_PREFIX
--with-openssl=$NEOTERM_PREFIX
--with-yaml=$NEOTERM_PREFIX
--with-pcre=$NEOTERM_PREFIX
--with-prefix=$NEOTERM_PREFIX
--with-libxml2=$NEOTERM_PREFIX
"

neoterm_step_post_get_source() {
	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files. \nExpected ${NEOTERM_PKG_SHA256}\nActual ${s% *}"
	fi

	: ${_CFENGINE_GIT_TAG_SUFFIX:=}
	local _MASTERFILES_VERSION=${NEOTERM_PKG_VERSION#*:}${_CFENGINE_GIT_TAG_SUFFIX}
	local _MASTERFILES_SRCURL=https://github.com/cfengine/masterfiles/archive/${_MASTERFILES_VERSION}.zip
	local _MASTERFILES_SHA256=030c34f802a961feea9ed5cc74c5121287710d9f5da39a41bd49b99468f5caab
	local _MASTERFILES_FILE=${NEOTERM_PKG_CACHEDIR}/masterfiles-${_MASTERFILES_VERSION}.zip
	neoterm_download \
		${_MASTERFILES_SRCURL} \
		${_MASTERFILES_FILE} \
		${_MASTERFILES_SHA256}
	local d=$(unzip -qql ${_MASTERFILES_FILE} | \
			head -n1 | tr -s ' ' | cut -d' ' -f5-)
	unzip -q ${_MASTERFILES_FILE}
	mv ${d} masterfiles
}

neoterm_step_pre_configure() {
	export EXPLICIT_VERSION=${NEOTERM_PKG_VERSION#*:}
	export LDFLAGS+=" -landroid-glob"
	NO_CONFIGURE=1 ./autogen.sh
}

neoterm_step_post_make_install() {
	cd masterfiles
	./autogen.sh \
		--prefix=$NEOTERM_PREFIX/var/lib/cfengine \
		--bindir=$NEOTERM_PREFIX/bin
	make install
}

neoterm_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$NEOTERM_PREFIX/bin/sh
		# Generate a host key
		if [ ! -f $NEOTERM_PREFIX/var/lib/cfengine/ppkeys/localhost.priv ]; then
			$NEOTERM_PREFIX/bin/cf-key >/dev/null || :
		fi
	EOF
}
