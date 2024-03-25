NEOTERM_SUBPKG_DESCRIPTION="Python bindings and CLI tools for Frida"
NEOTERM_SUBPKG_INCLUDE="
bin/frida
bin/frida-apk
bin/frida-create
bin/frida-discover
bin/frida-kill
bin/frida-ls-devices
bin/frida-ps
bin/frida-trace
lib/python*
"
NEOTERM_SUBPKG_DEPENDS="python, python-pip"
NEOTERM_SUBPKG_CONFLICTS="frida-tools (<< 15.1.24)"
NEOTERM_SUBPKG_REPLACES="frida-tools (<< 15.1.24)"

neoterm_step_create_subpkg_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "pip${NEOTERM_PYTHON_VERSION} install 'prompt-toolkit>=2.0.0,<4.0.0' 'colorama>=0.2.7,<1.0.0' 'pygments<=2.0.2,<3.0.0'" >> postinst
}
