
# Samba SMB Share Info

## Setup

- `sudo apt install samba`
- Verify `/etc/samba/smb.conf`
- `sudo systemctl disable nmbd.service && sudo systemctl stop nmbd.service`
- `sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.old && sudo touch /etc/samba/smb.conf`
- Write `smb.conf` `[global]` details
- `testparm`
- Create users
- Write `[share]` details
- `testparm`
- `systemctl start smbd.service`

## Users and Directories

- `sudo mkdir /samba`
- `sudo chown :sambashare /samba/`

### Add user

- `adduser --no-create-home --shell /usr/sbin/nologin --ingroup sambashare <user>`
- `smbpasswd -a <user>`
- `smbpasswd -e <user>`

### Add Group

- Add user
- `groupadd <group>`
- `usermod -a -G <group> <user>`

## `smb.conf`

```text
[global]
    server string = fileshare
    server role = standalone server
    interfaces = lo eth0 192.168.10.0/24
    bind interfaces only = yes
    disable netbios = yes
    smb ports = 445
    log file = /var/log/samba/smb.log
    max log size = 10000

[share_name]
    path = /samba/<share>
    browseable = no
    read only = no
    force create mode = 0660
    force directory mode = 2770
    valid users = <user> @<group>
```

## Edit fstab to auto mount a drive

- `blkid` (su) to find UUID of drive
- Edit `/etc/fstab`
- Append `UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX /samba/ ext4    defaults    0   2`
- `chmod 770 /samba/`
