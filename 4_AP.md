# Wifi Hotspot

## Helpful Pages

- [Arch Wiki nmcli(1)](https://man.archlinux.org/man/nmcli.1)
- [Arch Wiki nm-settings-nmcli(5)](https://man.archlinux.org/man/nm-settings-nmcli.5.en)

## Creation

```bash
sudo nmcli device wifi hotspot ifname wlan0 con-name local-ap ssid accesspoint password 'PASSWORD'
```

## Connection (Testing)

sudo nmcli connection add type wifi ifname wlan0 con-name local-ap autoconnect yes ssid l-ap mode ap

sudo nmcli connection modify local-ap 802-11-wireless.mode ap 802-11-wireless-security.key-mgmt wpa-psk ipv4.method shared 802-11-wireless-security.psk 'PASSWORD'

sudo nmcli connection up local-ap
