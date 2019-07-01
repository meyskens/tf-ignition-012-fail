[Unit]
Description=postgresql data dir
After=data\x2da.mount

[Service]
Type=oneshot
RemainAfterExit=true
ExecStart=/usr/bin/mkdir -p ${data_dir}

[Install]
WantedBy=default.target
