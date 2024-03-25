NEOTERM_PKG_HOMEPAGE=https://forgejo.org/
NEOTERM_PKG_DESCRIPTION="Forgejo is a self-hosted lightweight software forge."
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.21.5-0"
NEOTERM_PKG_SRCURL=https://codeberg.org/forgejo/forgejo/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=3dadabd4a80888724f24c0d8550b7770717f973e8951e5e1e04280ba3a2c500e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="dash, git"
NEOTERM_PKG_CONFFILES="etc/forgejo/app.ini"

neoterm_step_pre_configure() {
	neoterm_setup_nodejs
	neoterm_setup_golang
}

neoterm_step_make() {
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/forgejo.org
	cp -a "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/forgejo.org/forgejo
	cd "$GOPATH"/src/forgejo.org/forgejo

	go mod init || :
	go mod tidy

	# Effectively a backport of https://github.com/lib/pq/commit/6a102c04ac8dc082f1684b0488275575c374cb4c.
	for f in "$GOPATH"/pkg/mod/github.com/lib/pq@*/user_posix.go; do
		chmod 0755 "$(dirname "$f")"
		chmod 0644 "$f"
		sed -i '/^\/\/ +build /s/ linux / linux,!android /g' "$f"
	done

	LDFLAGS=""
	LDFLAGS+=" -X forgejo.org/forgejo/modules/setting.CustomConf=$NEOTERM_PREFIX/etc/forgejo/app.ini"
	LDFLAGS+=" -X forgejo.org/forgejo/modules/setting.AppWorkPath=$NEOTERM_PREFIX/var/lib/forgejo"
	LDFLAGS+=" -X forgejo.org/forgejo/modules/setting.CustomPath=$NEOTERM_PREFIX/var/lib/forgejo"
	FORGEJO_VERSION=v"$NEOTERM_PKG_VERSION" TAGS="bindata sqlite sqlite_unlock_notify" make all
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/forgejo.org/forgejo/gitea \
		"$NEOTERM_PREFIX"/bin/forgejo

	mkdir -p "$NEOTERM_PREFIX"/etc/forgejo
	sed "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
		"$NEOTERM_PKG_BUILDER_DIR"/app.ini > "$NEOTERM_PREFIX"/etc/forgejo/app.ini
}

neoterm_step_post_massage() {
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/lib/forgejo
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/log/forgejo
}
