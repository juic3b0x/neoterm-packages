NEOTERM_SUBPKG_INCLUDE="lib/python*"
NEOTERM_SUBPKG_DESCRIPTION="The xcbgen Python module"
# Cannot depend on python due to circular dependency.
NEOTERM_SUBPKG_RECOMMENDS="python"
NEOTERM_SUBPKG_BREAKS="xcb-proto (<< 1.15.2)"
NEOTERM_SUBPKG_REPLACES="xcb-proto (<< 1.15.2)"
