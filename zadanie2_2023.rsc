# 2025-03-10 12:47:38 by RouterOS 7.18.2
# software id = V59B-6S0I
#
# model = RBD53iG-5HacD2HnD
# serial number = HJY0ATT76BX
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
set [ find default-name=wlan2 ] ssid=MikroTik
/interface vlan
add interface=bridge1 name=vlan1 vlan-id=1
add interface=bridge1 name=vlan2 vlan-id=2
add interface=bridge1 name=vlan3 vlan-id=3
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=pool2 ranges=10.27.20.10-10.27.20.15
/ip dhcp-server
add address-pool=pool2 interface=vlan2 name=dhcp2
/interface bridge port
add bridge=bridge1 interface=ether2
/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether2 vlan-ids=1
add bridge=bridge1 tagged=bridge1,ether2 vlan-ids=3
add bridge=bridge1 tagged=bridge1,ether2 vlan-ids=2
/ip address
add address=10.27.10.1/24 interface=vlan1 network=10.27.10.0
add address=10.27.20.1/24 interface=vlan2 network=10.27.20.0
add address=10.27.30.1/24 interface=vlan3 network=10.27.30.0
/ip dhcp-server network
add address=10.27.20.0/24 dns-server=10.27.30.3 gateway=10.27.20.1 netmask=24
/system note
set show-at-login=no
