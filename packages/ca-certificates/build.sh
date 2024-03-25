NEOTERM_PKG_HOMEPAGE=https://curl.se/docs/caextract.html
NEOTERM_PKG_DESCRIPTION="Common CA certificates"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:2023.12.12"
NEOTERM_PKG_SRCURL=https://curl.se/ca/cacert-$(sed 's/\./-/g' <<< ${NEOTERM_PKG_VERSION:2}).pem
NEOTERM_PKG_SHA256=ccbdfc2fe1a0d7bbbb9cc15710271acf1bb1afe4c8f1725fe95c4c7733fcbe5a
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	local CERTDIR=$NEOTERM_PREFIX/etc/tls
	local CERTFILE=$CERTDIR/cert.pem

	mkdir -p $CERTDIR

	neoterm_download $NEOTERM_PKG_SRCURL \
		$CERTFILE \
		$NEOTERM_PKG_SHA256
	touch $CERTFILE

	# Build java keystore which is split out into a ca-certificates-java subpackage:
	local KEYUTIL_JAR=$NEOTERM_PKG_CACHEDIR/keyutil-0.4.0.jar
	neoterm_download \
		https://github.com/use-sparingly/keyutil/releases/download/0.4.0/keyutil-0.4.0.jar \
		$KEYUTIL_JAR \
		18f1d2c82839d84949b1ad015343c509e81ef678c24db6112acc6c0761314610

	local JAVA_KEYSTORE_DIR=$NEOTERM_PREFIX/opt/openjdk-17/lib/security
	mkdir -p $JAVA_KEYSTORE_DIR

	java -jar $KEYUTIL_JAR \
		--import \
		--new-keystore $JAVA_KEYSTORE_DIR/jssecacerts \
		--password changeit \
		--force-new-overwrite \
		--import-pem-file $CERTFILE
}
