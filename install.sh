#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

PIP3=$(which pip3)

echo 'Installing packages'
if [ -z $PIP3 ]; then
  apt update
  apt -y install python3-pip
fi
pip3 install requests click configparser humanfriendly
echo 'Packages install completed'

echo 'Create dirs'
mkdir /var/log/opendtuctrl
mkdir -p /opt/opendtuctrl/config

echo 'Copy config and script'
cp ${SCRIPT_DIR}/config/opendtuctrl.ini.example /opt/opendtuctrl/config
cp ${SCRIPT_DIR}/opendtuctrl /opt/opendtuctrl
chmod a+x /opt/opendtuctrl/opendtuctrl

echo 'Create systemd file'
cat << EOF | tee /etc/systemd/system/opendtuctrl-dic.service
[Unit]
Description=openDTU dynamic-inverter-control
After=multi-user.target
[Service]
Type=simple
Restart=always
ExecStart=/usr/bin/python3 /opt/opendtuctrl/opendtuctrl dynamic-inverter-control
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

echo '#################'
echo 'Edit config /opt/opendtuctrl/config/opendtuctrl.ini.example and rename it to opendtuctrl.ini'
echo 'Enable service with: systemctl enable opendtuctrl-dic.service'
echo 'Start service with: systemctl start opendtuctrl-dic.service'

