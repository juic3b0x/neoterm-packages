neoterm_git_clone_src() {
	local TMP_CHECKOUT=$NEOTERM_PKG_CACHEDIR/tmp-checkout
	local TMP_CHECKOUT_VERSION=$NEOTERM_PKG_CACHEDIR/tmp-checkout-version

	if [ ! -f $TMP_CHECKOUT_VERSION ] || [ "$(cat $TMP_CHECKOUT_VERSION)" != "$NEOTERM_PKG_VERSION" ]; then
		if [ "$NEOTERM_PKG_GIT_BRANCH" == "" ]; then
			NEOTERM_PKG_GIT_BRANCH=v${NEOTERM_PKG_VERSION#*:}
		fi

		rm -rf $TMP_CHECKOUT
		git clone --depth 1 \
			--branch $NEOTERM_PKG_GIT_BRANCH \
			${NEOTERM_PKG_SRCURL:4} \
			$TMP_CHECKOUT

		pushd $TMP_CHECKOUT
		git submodule update --init --recursive --depth=1
		popd

		echo "$NEOTERM_PKG_VERSION" > $TMP_CHECKOUT_VERSION
	fi

	rm -rf $NEOTERM_PKG_SRCDIR
	cp -Rf $TMP_CHECKOUT $NEOTERM_PKG_SRCDIR
}
