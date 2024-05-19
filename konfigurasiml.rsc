# may/19/2024 19:06:28 by RouterOS 6.48.6
# software id = 38N4-H6JM
#
# model = RB941-2nD
# serial number = HE308K9E9XM
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk mode=dynamic-keys name=ROMEL \
    supplicant-identity="" wpa2-pre-shared-key=Rg201103
add authentication-types=wpa2-psk mode=dynamic-keys name=SONU \
    supplicant-identity="" wpa2-pre-shared-key=aaaaaaaa
add authentication-types=wpa2-psk mode=dynamic-keys name="UTAMI DEWI" \
    supplicant-identity="" wpa2-pre-shared-key=mbahpragak1966
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n disabled=no frequency=2462 \
    security-profile="UTAMI DEWI" ssid="Agen BRILink UD"
/ip pool
add name=dhcp_pool0 ranges=10.10.10.2-10.10.10.254
add name=dhcp_pool1 ranges=192.168.9.1,192.168.9.3-192.168.9.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether4 name=dhcp1
add address-pool=dhcp_pool1 disabled=no interface=ether2 name=dhcp2
/queue simple
add max-limit=5M/5M name=queue1 packet-marks="PAKET ML" priority=1/1 queue=\
    pcq-upload-default/pcq-download-default target=10.10.10.0/24
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip address
add address=192.168.9.1/24 interface=ether2 network=192.168.9.0
add address=10.10.10.1/24 interface=ether4 network=10.10.10.0
/ip dhcp-client
add disabled=no interface=wlan1
add disabled=no interface=ether1
/ip dhcp-server network
add address=10.10.10.0/24 gateway=10.10.10.1
add address=192.168.9.0/24 gateway=192.168.9.2
/ip firewall address-list
add address=10.10.10.0/24 list="IP LAN"
/ip firewall filter
add action=drop chain=forward dst-address-list="!MOBILE LEGEND" in-interface=\
    ether4 out-interface=wlan1
/ip firewall mangle
add action=mark-connection chain=prerouting dst-address-list="MOBILE LEGEND" \
    new-connection-mark="KONEKSI ML" passthrough=yes src-address-list=\
    "IP LAN"
add action=mark-packet chain=forward connection-mark="KONEKSI ML" \
    new-packet-mark="PAKET ML" passthrough=no
/ip firewall nat
add action=masquerade chain=srcnat out-interface=wlan1
add action=masquerade chain=srcnat out-interface=ether1
/ip firewall raw
add action=add-dst-to-address-list address-list="MOBILE LEGEND" \
    address-list-timeout=none-dynamic chain=prerouting dst-port=\
    5000-5221,5224-5227,5229-5241,5243-5508,5551-5559,5601-5700,9001,9443 \
    protocol=tcp src-address-list="IP LAN"
add action=add-dst-to-address-list address-list="MOBILE LEGEND" \
    address-list-timeout=none-dynamic chain=prerouting dst-port=\
    5520-5529,10003,30000-30300 protocol=tcp src-address-list="IP LAN"
add action=add-dst-to-address-list address-list="MOBILE LEGEND" \
    address-list-timeout=none-dynamic chain=prerouting dst-port=\
    4001-4009,5000-5221,5224-5241,5243-5508,5551-5559,5601-5700 protocol=udp \
    src-address-list="IP LAN"
add action=add-dst-to-address-list address-list="MOBILE LEGEND" \
    address-list-timeout=none-dynamic chain=prerouting dst-port=\
    2702,3702,5517,5520-5529,8001,9000-9010,9992,10003,30000-30300 protocol=\
    udp src-address-list="IP LAN"
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes port=1945
set ssh disabled=yes
set api disabled=yes
set winbox port=8090
set api-ssl disabled=yes
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name=Sonu-Core
