# openDTUctrl

sudo ./install.sh

Edit config /opt/opendtuctrl/config/opendtuctrl.ini.example and rename it to opendtuctrl.ini

Use script manual:
/opt/opendtuctrl/opendtuctrl

Enable dynamic-inverter-control:
systemctl enable opendtuctrl-dic.service
systemctl start opendtuctrl-dic.service

