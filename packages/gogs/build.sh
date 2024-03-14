NEOTERM_PKG_HOMEPAGE=https://gogs.io
NEOTERM_PKG_DESCRIPTION="A painless self-hosted Git service"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Injamul Mohammad Mollah <mrinjamul@gmail.com>"
NEOTERM_PKG_VERSION="0.13.0"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/gogs/gogs/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=59a8c4349ed104ccd44985e940a6cdb25fca1a6019212e7f65b30f1252f627ce
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="dash, git"
NEOTERM_PKG_CONFFILES="etc/gogs/app.ini"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_HOSTBUILD_DIR
	mkdir -p $NEOTERM_PKG_HOSTBUILD_DIR
	cd $NEOTERM_PKG_HOSTBUILD_DIR
	go install github.com/kevinburke/go-bindata/go-bindata@v3.24.0
}

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/gogs.io
	cp -a "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/gogs.io/gogs
	cd "$GOPATH"/src/gogs.io/gogs

	LDFLAGS=""
	LDFLAGS+=" -X gogs.io/gogs/internal/conf.CustomConf=$NEOTERM_PREFIX/etc/gogs/app.ini"
	LDFLAGS+=" -X gogs.io/gogs/internal/conf.AppWorkPath=$NEOTERM_PREFIX/var/lib/gogs"
	LDFLAGS+=" -X gogs.io/gogs/internal/conf.CustomPath=$NEOTERM_PREFIX/var/lib/gogs"

	PATH=$PATH:$NEOTERM_PKG_HOSTBUILD_DIR/bin go build -ldflags "${LDFLAGS}" -tags "bindata sqlite" -trimpath -o gogs
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/gogs.io/gogs/gogs \
		"$NEOTERM_PREFIX"/bin/gogs

	mkdir -p "$NEOTERM_PREFIX"/etc/gogs
	sed "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
		"$NEOTERM_PKG_BUILDER_DIR"/app.ini > "$NEOTERM_PREFIX"/etc/gogs/app.ini
}

neoterm_step_post_massage() {
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/lib/gogs
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/log/gogs
}
