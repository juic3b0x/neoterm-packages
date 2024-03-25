NEOTERM_PKG_HOMEPAGE=https://golang.org/
NEOTERM_PKG_DESCRIPTION="Go programming language compiler"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=1.21
# Use the ~ deb versioning construct in the future:
NEOTERM_PKG_VERSION=3:${_MAJOR_VERSION}.6
NEOTERM_PKG_SRCURL=https://storage.googleapis.com/golang/go${NEOTERM_PKG_VERSION#*:}.src.tar.gz
NEOTERM_PKG_SHA256=124926a62e45f78daabbaedb9c011d97633186a33c238ffc1e25320c02046248
NEOTERM_PKG_DEPENDS="clang"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="clang"
NEOTERM_PKG_RECOMMENDS="resolv-conf"
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_post_get_source() {
	. $NEOTERM_PKG_BUILDER_DIR/fix-hardcoded-etc-resolv-conf.sh
}

neoterm_step_make_install() {
	neoterm_setup_golang

	NEOTERM_GOLANG_DIRNAME=${GOOS}_$GOARCH
	NEOTERM_GODIR=$NEOTERM_PREFIX/lib/go
	local LINKER=/system/bin/linker
	if [ "${NEOTERM_ARCH}" == "x86_64" ] || [ "${NEOTERM_ARCH}" == "aarch64" ]; then
		LINKER+=64
	fi
	cd $NEOTERM_PKG_SRCDIR/src
	# Unset PKG_CONFIG to avoid the path being hardcoded into src/cmd/cgo/zdefaultcc.go,
	# see https://github.com/juic3b0x/neoterm-packages/issues/3505.
	env CC_FOR_TARGET=$CC \
	    CXX_FOR_TARGET=$CXX \
	    CC=gcc \
	    GO_LDFLAGS="-extldflags=-pie" \
	    GO_LDSO="$LINKER" \
	    GOROOT_BOOTSTRAP=$GOROOT \
	    GOROOT_FINAL=$NEOTERM_GODIR \
	    PKG_CONFIG= \
	    ./make.bash

	cd ..
	rm -Rf $NEOTERM_GODIR
	mkdir -p $NEOTERM_GODIR/{bin,src,doc,lib,pkg/tool/$NEOTERM_GOLANG_DIRNAME,pkg/include}
	cp bin/$NEOTERM_GOLANG_DIRNAME/{go,gofmt} $NEOTERM_GODIR/bin/
	ln -sfr $NEOTERM_GODIR/bin/go $NEOTERM_PREFIX/bin/go
	ln -sfr $NEOTERM_GODIR/bin/gofmt $NEOTERM_PREFIX/bin/gofmt
	cp VERSION $NEOTERM_GODIR/
	cp pkg/tool/$NEOTERM_GOLANG_DIRNAME/* $NEOTERM_GODIR/pkg/tool/$NEOTERM_GOLANG_DIRNAME/
	cp -Rf src/* $NEOTERM_GODIR/src/
	cp -Rf doc/* $NEOTERM_GODIR/doc/
	cp pkg/include/* $NEOTERM_GODIR/pkg/include/
	cp -Rf lib/* $NEOTERM_GODIR/lib
	cp -Rf misc/ $NEOTERM_GODIR/
}

neoterm_step_post_massage() {
	find . -path '*/testdata*' -delete
}
