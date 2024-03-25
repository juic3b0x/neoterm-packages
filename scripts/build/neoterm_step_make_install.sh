# shellcheck disable=SC2086
neoterm_step_make_install() {
	[ "$NEOTERM_PKG_METAPACKAGE" = "true" ] && return

	if test -f build.ninja; then
		ninja -w dupbuild=warn -j $NEOTERM_MAKE_PROCESSES install
	elif test -f setup.py || test -f pyproject.toml || test -f setup.cfg; then
		pip install --no-deps . --prefix $NEOTERM_PREFIX
	elif ls ./*.cabal &>/dev/null; then
		# Workaround until `cabal install` is fixed.
		while read -r bin; do
			[[ -f "$bin" ]] || neoterm_error_exit "'$bin', no such file. Has build completed?"
			echo "INFO: Installing '$bin' component..."
			cp "$bin" "$NEOTERM_PREFIX/bin"
		done< <(cat ./dist-newstyle/cache/plan.json | jq -r '."install-plan"[]|select(."component-name"? and (."component-name"|test("exe:.*")) and (.style == "local") )|."bin-file"')
	elif ls ./*akefile &>/dev/null || [ -n "$NEOTERM_PKG_EXTRA_MAKE_ARGS" ]; then
		: "${NEOTERM_PKG_MAKE_INSTALL_TARGET:="install"}"
		# Some packages have problem with parallell install, and it does not buy much, so use -j 1.
		if [ -z "$NEOTERM_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j 1 ${NEOTERM_PKG_MAKE_INSTALL_TARGET}
		else
			make -j 1 ${NEOTERM_PKG_EXTRA_MAKE_ARGS} ${NEOTERM_PKG_MAKE_INSTALL_TARGET}
		fi
	elif test -f Cargo.toml; then
		neoterm_setup_rust
		cargo install \
			--jobs $NEOTERM_MAKE_PROCESSES \
			--path . \
			--force \
			--locked \
			--no-track \
			--target $CARGO_TARGET_NAME \
			--root $NEOTERM_PREFIX \
			$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
	fi
}
