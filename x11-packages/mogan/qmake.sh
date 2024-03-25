#!/usr/bin/env bash

qmake_output=$(@NEOTERM_PREFIX@/opt/qt/cross/bin/qmake $@)

echo "${qmake_output}" | \
sed \
	-e "s|^QT_INSTALL_BINS:.*|QT_INSTALL_BINS:@NEOTERM_PREFIX@/opt/qt/cross/bin|"
