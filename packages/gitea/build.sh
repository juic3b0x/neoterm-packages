NEOTERM_PKG_HOMEPAGE=https://gitea.io
NEOTERM_PKG_DESCRIPTION="Git with a cup of tea, painless self-hosted git service"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.21.5"
NEOTERM_PKG_SRCURL=https://github.com/go-gitea/gitea/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=d6f1ab196011cb53e98abfa2a85d7b5a730a69ea426cc1e24a451e410b76a7a5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="dash, git"
NEOTERM_PKG_CONFFILES="etc/gitea/app.ini"

neoterm_step_pre_configure() {
	neoterm_setup_nodejs
	neoterm_setup_golang
}

neoterm_step_make() {
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/code.gitea.io
	cp -a "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/code.gitea.io/gitea
	cd "$GOPATH"/src/code.gitea.io/gitea

	go mod init || :
	go mod tidy

	# Effectively a backport of https://github.com/lib/pq/commit/6a102c04ac8dc082f1684b0488275575c374cb4c.
	for f in "$GOPATH"/pkg/mod/github.com/lib/pq@*/user_posix.go; do
		chmod 0755 "$(dirname "$f")"
		chmod 0644 "$f"
		sed -i '/^\/\/ +build /s/ linux / linux,!android /g' "$f"
	done

	LDFLAGS=""
	LDFLAGS+=" -X code.gitea.io/gitea/modules/setting.CustomConf=$NEOTERM_PREFIX/etc/gitea/app.ini"
	LDFLAGS+=" -X code.gitea.io/gitea/modules/setting.AppWorkPath=$NEOTERM_PREFIX/var/lib/gitea"
	LDFLAGS+=" -X code.gitea.io/gitea/modules/setting.CustomPath=$NEOTERM_PREFIX/var/lib/gitea"
	GITEA_VERSION=v"$NEOTERM_PKG_VERSION" TAGS="bindata sqlite sqlite_unlock_notify" make all
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/code.gitea.io/gitea/gitea \
		"$NEOTERM_PREFIX"/bin/gitea

	mkdir -p "$NEOTERM_PREFIX"/etc/gitea
	sed "s%\@NEOTERM_PREFIX\@%${NEOTERM_PREFIX}%g" \
		"$NEOTERM_PKG_BUILDER_DIR"/app.ini > "$NEOTERM_PREFIX"/etc/gitea/app.ini
}

neoterm_step_post_massage() {
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/lib/gitea
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX"/var/log/gitea
}
