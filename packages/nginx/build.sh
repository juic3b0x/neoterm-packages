NEOTERM_PKG_HOMEPAGE=https://www.nginx.org
NEOTERM_PKG_DESCRIPTION="Lightweight HTTP server"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.25.4"
NEOTERM_PKG_SRCURL=https://nginx.org/download/nginx-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=760729901acbaa517996e681ee6ea259032985e37c2768beef80df3a877deed9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-glob, libcrypt, pcre2, openssl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SERVICE_SCRIPT=("nginx" "mkdir -p $NEOTERM_ANDROID_HOME/.nginx\nif [ -f \"$NEOTERM_ANDROID_HOME/.nginx/nginx.conf\" ]; then CONFIG=\"$NEOTERM_ANDROID_HOME/.nginx/nginx.conf\"; else CONFIG=\"$NEOTERM_PREFIX/etc/nginx/nginx.conf\"; fi\nexec nginx -p ~/.nginx -g \"daemon off;\" -c \$CONFIG 2>&1")
NEOTERM_PKG_CONFFILES="
etc/nginx/fastcgi.conf
etc/nginx/fastcgi_params
etc/nginx/koi-win
etc/nginx/koi-utf
etc/nginx/mime.types
etc/nginx/nginx.conf
etc/nginx/scgi_params
etc/nginx/uwsgi_params
etc/nginx/win-utf"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	CPPFLAGS="$CPPFLAGS -DIOV_MAX=1024"
	LDFLAGS="$LDFLAGS -landroid-glob"

	# remove config from previous installs
	rm -rf "$NEOTERM_PREFIX/etc/nginx"
}

neoterm_step_configure() {
	DEBUG_FLAG=""
	$NEOTERM_DEBUG_BUILD && DEBUG_FLAG="--with-debug"

	./configure \
		--prefix=$NEOTERM_PREFIX \
		--crossbuild="Linux:3.16.1:$NEOTERM_ARCH" \
		--crossfile="$NEOTERM_PKG_SRCDIR/auto/cross/Android" \
		--with-cc=$CC \
		--with-cpp=$CPP \
		--with-cc-opt="$CPPFLAGS $CFLAGS" \
		--with-ld-opt="$LDFLAGS" \
		--with-threads \
		--sbin-path="$NEOTERM_PREFIX/bin/nginx" \
		--conf-path="$NEOTERM_PREFIX/etc/nginx/nginx.conf" \
		--http-log-path="$NEOTERM_PREFIX/var/log/nginx/access.log" \
		--pid-path="$NEOTERM_PREFIX/tmp/nginx.pid" \
		--lock-path="$NEOTERM_PREFIX/tmp/nginx.lock" \
		--error-log-path="$NEOTERM_PREFIX/var/log/nginx/error.log" \
		--http-client-body-temp-path="$NEOTERM_PREFIX/var/lib/nginx/client-body" \
		--http-proxy-temp-path="$NEOTERM_PREFIX/var/lib/nginx/proxy" \
		--http-fastcgi-temp-path="$NEOTERM_PREFIX/var/lib/nginx/fastcgi" \
		--http-scgi-temp-path="$NEOTERM_PREFIX/var/lib/nginx/scgi" \
		--http-uwsgi-temp-path="$NEOTERM_PREFIX/var/lib/nginx/uwsgi" \
		--with-http_auth_request_module \
		--with-http_ssl_module \
		--with-http_v2_module \
		--with-http_gunzip_module \
		--with-http_sub_module \
		--with-stream \
		--with-stream_ssl_module \
		$DEBUG_FLAG
}

neoterm_step_post_make_install() {
	# many parts are taken directly from Arch PKGBUILD
	# https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/nginx

	# set default port to 8080
	sed -i "s| 80;| 8080;|" "$NEOTERM_PREFIX/etc/nginx/nginx.conf"
	cp conf/mime.types "$NEOTERM_PREFIX/etc/nginx/"
	rm "$NEOTERM_PREFIX"/etc/nginx/*.default

	# move default html dir
	sed -e "44s|html|$NEOTERM_PREFIX/share/nginx/html|" \
		-e "54s|html|$NEOTERM_PREFIX/share/nginx/html|" \
		-i "$NEOTERM_PREFIX/etc/nginx/nginx.conf"
	rm -rf "$NEOTERM_PREFIX/share/nginx"
	mkdir -p "$NEOTERM_PREFIX/share/nginx"
	mv "$NEOTERM_PREFIX/html/" "$NEOTERM_PREFIX/share/nginx"

	# install vim contrib
	for i in ftdetect indent syntax; do
		install -Dm644 "$NEOTERM_PKG_SRCDIR/contrib/vim/${i}/nginx.vim" \
			"$NEOTERM_PREFIX/share/vim/vimfiles/${i}/nginx.vim"
	done

	# install man pages
	mkdir -p "$NEOTERM_PREFIX/share/man/man8"
	cp "$NEOTERM_PKG_SRCDIR/man/nginx.8" "$NEOTERM_PREFIX/share/man/man8/"
}

neoterm_step_post_massage() {
	# keep empty dirs which were deleted in massage
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/var/log/nginx"
	for dir in client-body proxy fastcgi scgi uwsgi; do
		mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/var/lib/nginx/$dir"
	done
}
