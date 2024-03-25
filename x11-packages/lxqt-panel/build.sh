NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="The LXQt desktop panel"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/lxqt-panel/releases/download/${NEOTERM_PKG_VERSION}/lxqt-panel-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=0e660c0397c96a28f0fcf316b20c72d203c85793a884e1487b3b14e3790defc9
NEOTERM_PKG_DEPENDS="kwindowsystem, libc++, libdbusmenu-qt, liblxqt, libsysstat, libxcb, libxkbcommon, libxtst, libxtst, lxmenu-data, lxqt-globalkeys, lxqt-menu-data, pulseaudio, qt5-qtbase, qt5-qtx11extras, xcb-util, xcb-util-image"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
# TODO
# CPULOAD and NETWORKMONITOR require libstatgrab
# MOUNT plugin requires KF5Solid
# SENSORS plugin requires lm_sensors
# COLORPICKER gives an error when building: no member named 'setAccessibleName' in 'QMenu'
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCOLORPICKER_PLUGIN=OFF
-DCPULOAD_PLUGIN=OFF
-DNETWORKMONITOR_PLUGIN=OFF
-DMOUNT_PLUGIN=OFF
-DSENSORS_PLUGIN=OFF
-DVOLUME_USE_ALSA=OFF
"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	# Add RUNPATH to the private libraries used by lxqt-panel's plugins
	LDFLAGS+=" -Wl,-rpath=${NEOTERM_PREFIX}/lib/lxqt-panel"
	export LDFLAGS
}
