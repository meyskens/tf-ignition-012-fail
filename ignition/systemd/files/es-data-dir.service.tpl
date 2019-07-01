[Unit]
Description=elasticsearch data dir
After=data.mount

[Service]
Type=oneshot
RemainAfterExit=true
ExecStartPre=/usr/bin/mkdir -p ${data_dir}/master
ExecStart=/usr/bin/mkdir -p ${data_dir}/data

[Install]
WantedBy=default.target
