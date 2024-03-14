NEOTERM_PKG_HOMEPAGE=https://grafana.com/
NEOTERM_PKG_DESCRIPTION="The open-source platform for monitoring and observability"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=8.5.27
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/grafana/grafana
NEOTERM_PKG_BUILD_DEPENDS="yarn"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="SPEC_TARGET= MERGED_SPEC_TARGET="

neoterm_step_pre_configure() {
	neoterm_setup_golang
	neoterm_setup_nodejs

	local bin=$NEOTERM_PKG_BUILDDIR/_bin
	mkdir -p $bin
	GOOS=linux GOARCH=amd64 go build build.go
	mv build $bin/_build
	local goexec=$bin/go_$(go env GOOS)_$(go env GOARCH)_exec
	cat > $goexec <<-EOF
		#!$(command -v sh)
		shift
		exec $bin/_build -goos=$GOOS -goarch=$GOARCH "\$@"
		EOF
	chmod 0755 $goexec

	local yarn=$bin/yarn
	cat > $yarn <<-EOF
		#!$(command -v sh)
		exec sh $NEOTERM_PREFIX/bin/yarn "\$@"
		EOF
	chmod 0755 $yarn

	export PATH=$bin:$PATH

	export NODE_OPTIONS=--max-old-space-size=6000
	NODE_OPTIONS+=" --openssl-legacy-provider"

	yarn set version 3.2.4
}

neoterm_step_make() {
	make $NEOTERM_PKG_EXTRA_MAKE_ARGS build-go
	make $NEOTERM_PKG_EXTRA_MAKE_ARGS deps-js
	make $NEOTERM_PKG_EXTRA_MAKE_ARGS build-js
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/*/grafana-server bin/*/grafana-cli
	local sharedir=$NEOTERM_PREFIX/share/grafana
	mkdir -p $sharedir
	for d in conf public; do
		cp -rT $d $sharedir/$d
	done
}
