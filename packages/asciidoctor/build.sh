NEOTERM_PKG_HOMEPAGE=https://asciidoctor.org/
NEOTERM_PKG_DESCRIPTION="An implementation of AsciiDoc in Ruby"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.20
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="ruby"
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_pre_configure() {
	ruby_version=$(. $NEOTERM_SCRIPTDIR/packages/ruby/build.sh; echo $NEOTERM_PKG_VERSION)
}

neoterm_step_make_install() {
	local gemdir="$NEOTERM_PREFIX/lib/ruby/gems/${ruby_version:0:3}.0"

	rm -rf "$gemdir/asciidoctor-$NEOTERM_PKG_VERSION"
	rm -rf "$gemdir/doc/asciidoctor-$NEOTERM_PKG_VERSION"

	gem install --ignore-dependencies --no-user-install --verbose \
		-i "$gemdir" -n "$NEOTERM_PREFIX/bin" asciidoctor -v "$NEOTERM_PKG_VERSION"

	sed -i -E "1 s@^(#\!)(.*)@\1${NEOTERM_PREFIX}/bin/ruby@" \
		"$NEOTERM_PREFIX/bin/asciidoctor"

	install -Dm600 "$gemdir/gems/asciidoctor-${NEOTERM_PKG_VERSION}/man/asciidoctor.1" \
		"$NEOTERM_PREFIX/share/man/main1/asciidoctor.1"
}

neoterm_step_install_license() {
	local gemdir="$NEOTERM_PREFIX/lib/ruby/gems/${ruby_version:0:3}.0"
	mkdir -p $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME
	cp $gemdir/gems/asciidoctor-${NEOTERM_PKG_VERSION}/LICENSE \
		$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/
}
