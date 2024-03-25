NEOTERM_SUBPKG_DESCRIPTION="Swift runtime libraries for Android x86_64"
NEOTERM_SUBPKG_INCLUDE="opt/ndk-multilib/x86_64-linux-android/lib/lib[FXs]*.so"
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=true
NEOTERM_SUBPKG_DEPEND_ON_PARENT=no
NEOTERM_SUBPKG_DEPENDS="ndk-multilib"

neoterm_step_create_subpkg_debscripts() {
	local file
	for file in postinst prerm; do
		sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
			-e "s|@NEOTERM_PACKAGE_FORMAT@|${NEOTERM_PACKAGE_FORMAT}|g" \
			-e "s|@SWIFT_TRIPLE@|x86_64-linux-android|g" \
			$NEOTERM_PKG_BUILDER_DIR/trigger-header > "${file}"
	done
	sed 's|@COMMAND@|ln -sf "'$NEOTERM_PREFIX'/opt/ndk-multilib/x86_64-linux-android/lib/lib$so.so" "$install_path"|' \
		$NEOTERM_PKG_BUILDER_DIR/trigger-command >> postinst
	sed 's|@COMMAND@|rm -f "$install_path/lib$so.so"|' \
		$NEOTERM_PKG_BUILDER_DIR/trigger-command >> prerm
	chmod 0700 postinst prerm
}
