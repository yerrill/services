# Wireguard Full Tunnel Setup

Standard:

```bash
sudo apt update -y && sudo apt upgrade -y
sudo apt install wireguard
```

Uncomment `net.ipv4.ip_forward=1` from `/etc/sysctl.conf` and `sysctl -p`

In `/etc/wireguard`:

`wg genkey > privatekey && wg pubkey < privatekey > publickey`

Creating `/etc/wireguard/wg0.conf`:

```text
[Interface]
PrivateKey = <Server private key>
Address = 192.168.10.1/24
ListenPort = 51820
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE


[Peer]
# Client
PublicKey=<The Public Key of the Client>
AllowedIPs=192.168.10.2/32

#... More peers
```

Client Machine:

```text
[Interface]
PrivateKey=<Client Private Key>
Address=192.168.10.2/32
DNS=1.1.1.1

[Peer]
# Server
PublicKey=<Public Key From Server>
Endpoint=<Public IP of server>:51820
AllowedIPs=0.0.0.0/0
```

- `wg-quick up wg0` & `wg-quick down`
- `systemctl enable wg-quick@wg0`, `systemctl start wg-quick@wg`
- `systemctl disable wg-quick@wg`, `systemctl stop wg-quick@wg0`
- `systemctl status wg-quick@wg0`,
