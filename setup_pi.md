# Setup raspberry pi

## 1. Create bootable media

With Raspberry Pi Imager, choose OS "Raspberry Pi OS (64-bit)", Storage connected SSD.
From the gear icon in the lower right corner, set hostname "pi", check "Enable SSH",
Set username "takahisa" and set password.
Check "Configure wireless LAN" and set wifi SSID and password. Set locale.
Click "SAVE" and "WRITE". Click "YES" for confirmation.

Connect the external storage to Raspberry Pi, and power on the Pi.

## 2. Setup pi

### 2.1. Connect to pi via SSH

```bash
ssh takahisa@pi.local
```

If it did not work, we can connect by using IP address.
First, search Raspberry Pi's local IP address.

Confirm default gate way.

```bash
ip route list
```

```console
default via 192.168.1.1 dev wlan0 proto dhcp src 192.168.1.159 metric 600
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown
192.168.1.0/24 dev wlan0 proto kernel scope link src 192.168.1.159 metric 600
```

```bash
nmap -sP 192.168.1.1/24
```

```console
Starting Nmap 7.93 ( https://nmap.org ) at 2023-05-06 13:37 CEST
Nmap scan report for hh40.home (192.168.1.1)
Host is up (0.024s latency).
Nmap scan report for msi (192.168.1.159)
Host is up (0.000021s latency).
Nmap scan report for 192.168.1.219
Host is up (0.087s latency).
Nmap scan report for Pixel-6 (192.168.1.242)
Host is up (0.042s latency).
Nmap done: 256 IP addresses (4 hosts up) scanned in 3.19 seconds
```

If run `nmap` with `sudo`, MAC addresses is also shown. If Raspberry Pi's IP
is `192.168.1.219`, ssh with following command.

```bash
ssh takahisa@192.168.1.219
```

### 2.2. Fix local ip address and enable VNC

The following commands must be executed while connected to ssh.

```bash
sudo raspi-config
```

Then, setup followings.

- Display Options > VNC Resolution > 1920x1080
- Interface Options > VNC > Enable VNC
- Performance Options > Fan > Enable temperature control GPIO 14, 80 degree Celsius

Reboot may be required.

Edit `/etc/dhcpcd.conf`

```bash
sudo vi /etc/dhcpcd.conf
```

add followings.

```conf
static ip_address=192.168.1.112/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
```

If not worked, configure followings from GUI.
(Confirm current settings with `ifconfig`)

IPv4 Settings > Manual > Address Add

```text
Address: 192.168.1.112
Netmask: 255.255.255.0
Gateway: 192.168.1.1
DNS servers: 192.168.1.1
```

## 3. Install InfluxDB OSS

```bash
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
sudo apt-get update && sudo apt-get install influxdb2
```

Set sysctrl services

```bash
sudo systemctl unmask influxdb.service
sudo systemctl start influxdb
sudo systemctl enable influxdb.service
```

Add following section to `~/.ssh/config` in local machine.

```bash
Host pi
   HostName 192.168.1.112
   User takahisa
   LocalForward 8086 localhost:8086
```

Then, `ssh pi` will connect to the Raspberry Pi. InfluxDB web interface is
accessible at <http://localhost:8086> from local browser.

## Initialize InfluxDB

From web interface go "GET STARTED", and set as follows.

Username: takahisa
Password: ********
Confirm Password: ********
Initial Organization Name: admin
Initial Bucket Name: home

Then save API token.

Then, go to "Get Started".

## Setting up Python

Follow instructions.

In Pi,

```bash
pip3 install influxdb-client
```

## Setup Docusaurus

### Install dependency

Node.js and yarn are required.

```bash
# https://pimylifeup.com/raspberry-pi-nodejs/
sudo apt update
sudo apt upgrade
sudo apt install -y ca-certificates curl gnupg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/nodesource.gpg
echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install -y nodejs
```

check version

```bash
node -v
npm -v
```

### Clone repository

- setup deploy key
- clone repository

### Start server

```bash
cd my-website
npm install
npx docusaurus --version
npm run serve -- --host 0.0.0.0
```
Then, the website is accessible from local network.
