for f in src/net/conf_android.go src/net/dnsclient_android.go; do
	if [ -e "${f}" ]; then
		neoterm_error_exit "Error: file ${f} already exists."
	fi
done

cp -T src/net/conf.go src/net/conf_android.go
cp -T src/net/dnsclient_unix.go src/net/dnsclient_android.go

sed -e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" \
	${NEOTERM_SCRIPTDIR}/packages/golang/fix-hardcoded-etc-resolv-conf.diff \
	| patch --silent -p1
