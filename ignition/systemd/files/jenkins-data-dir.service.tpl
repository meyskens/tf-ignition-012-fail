[Unit]
Description=jenkins data dir
After=data-a.mount

[Service]
Type=oneshot
RemainAfterExit=true
ExecStart=/usr/bin/mkdir -p ${data_dir}

[Install]
WantedBy=default.target
