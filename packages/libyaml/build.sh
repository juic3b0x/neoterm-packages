NEOTERM_PKG_HOMEPAGE=https://pyyaml.org/wiki/LibYAML
NEOTERM_PKG_DESCRIPTION="LibYAML is a YAML 1.1 parser and emitter written in C"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2.5
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/yaml/libyaml/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=fa240dbf262be053f3898006d502d514936c818e422afdcf33921c63bed9bf2e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libyaml-dev"
NEOTERM_PKG_REPLACES="libyaml-dev"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after RELEASE / SOVERSION is changed.
	local _RELEASE=0
	local _SOVERSION=2

	local a
	for a in YAML_RELEASE YAML_CURRENT YAML_AGE; do
		local _${a}=$(sed -En 's/^m4_define\(\['"${a}"'\],\s*([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _YAML_CURRENT - _YAML_AGE ))
	if [ "${_RELEASE}" != "${_YAML_RELEASE}" ] || \
		[ ! "${_YAML_CURRENT}" ] || [ "${_SOVERSION}" != "${v}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	./bootstrap
}

neoterm_step_post_make_install() {
	cd $NEOTERM_PREFIX/lib
	ln -s -f libyaml-0.so libyaml.so
}
