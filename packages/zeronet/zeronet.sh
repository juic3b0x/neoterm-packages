#!@NEOTERM_PREFIX@/bin/bash
exec @NEOTERM_PREFIX@/opt/zeronet/zeronet.py \
	--config_file @NEOTERM_PREFIX@/etc/zeronet.conf \
	--data_dir @NEOTERM_PREFIX@/var/lib/zeronet \
	--log_dir @NEOTERM_PREFIX@/var/log/zeronet "$@"
