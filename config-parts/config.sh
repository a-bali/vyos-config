#!/bin/vbash

set container name pihole environment DNSMASQ_LISTENING value 'single'
set container name pihole environment FTLCONF_NAMES_FROM_NETDB value 'false'
set container name pihole environment PIHOLE_DNS_ value '1.1.1.1;1.0.1.1'
set container name pihole environment REV_SERVER value 'true'
set container name pihole environment REV_SERVER_CIDR value '192.168.0.0/16'
set container name pihole environment REV_SERVER_TARGET value '192.168.1.111'
set container name pihole environment TZ value 'Europe/Budapest'
set container name pihole environment WEBPASSWORD value 'pihole'
set container name pihole image 'pihole/pihole:latest'
set container name pihole network containers address '192.168.3.2'
set container name pihole volume dnsmasq destination '/etc/dnsmasq.d'
set container name pihole volume dnsmasq mode 'rw'
set container name pihole volume dnsmasq source '/config/containers/pihole/dnsmasq'
set container name pihole volume pihole destination '/etc/pihole'
set container name pihole volume pihole mode 'rw'
set container name pihole volume pihole source '/config/containers/pihole/pihole'
set container name vnstat allow-host-networks
set container name vnstat environment EXCLUDE_PATTERN value '^docker|^veth|^br-|^lxc|^pim6reg'
set container name vnstat environment TZ value 'Europe/Budapest'
set container name vnstat image 'ghcr.io/vergoh/vnstat:2.11'
set container name vnstat memory '0'
set container name vnstat shared-memory '0'
set container name vnstat volume vnstat-data destination '/var/lib/vnstat'
set container name vnstat volume vnstat-data mode 'rw'
set container name vnstat volume vnstat-data source '/config/containers/vnstat'
set container network containers prefix '192.168.3.0/24'
set interfaces ethernet eth0 address 'dhcp'
set interfaces ethernet eth0 description 'WAN'
set interfaces ethernet eth1 address '192.168.1.111/24'
set interfaces ethernet eth1 description 'LAN'
set interfaces loopback lo
set nat source rule 11 outbound-interface 'eth0'
set nat source rule 11 source address '192.168.1.0/24'
set nat source rule 11 translation address 'masquerade'
set nat source rule 12 outbound-interface 'tailscale0'
set nat source rule 12 source address '192.168.0.0/16'
set nat source rule 12 translation address 'masquerade'
set service dhcp-server host-decl-name
set service dhcp-server hostfile-update
set service dhcp-server shared-network-name LAN domain-name 'lan'
set service dhcp-server shared-network-name LAN domain-search 'lan'
set service dhcp-server shared-network-name LAN domain-search 'snow-char.ts.net'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 default-router '192.168.1.111'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 lease '86400'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 name-server '192.168.1.111'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 range 0 start '192.168.1.20'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 range 0 stop '192.168.1.200'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping nas ip-address '192.168.1.200'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping nas mac-address 'd0:50:99:98:7f:df'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping openwrt1 ip-address '192.168.1.2'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping openwrt1 mac-address 'f4:f2:6d:9c:36:f7'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping openwrt2 ip-address '192.168.1.3'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping openwrt2 mac-address '28:ee:52:62:9d:5a'
set service dns forwarding allow-from '0.0.0.0/0'
set service dns forwarding domain snow-char.ts.net name-server 100.100.100.100
set service dns forwarding listen-address '192.168.1.111'
set service dns forwarding name-server 192.168.3.2
set service ntp allow-client address '0.0.0.0/0'
set service ntp allow-client address '::/0'
set service ntp server 0.pool.ntp.org
set service ntp server 1.pool.ntp.org
set service ntp server 2.pool.ntp.org
set service snmp community public authorization 'ro'
set service snmp community public network '192.168.1.0/24'
set service snmp listen-address 192.168.1.111 port '161'
set service snmp trap-target 192.168.1.182 community 'public'
set service ssh port 22
set system config-management commit-revisions '100'
set system conntrack modules ftp
set system conntrack modules h323
set system conntrack modules nfs
set system conntrack modules pptp
set system conntrack modules sip
set system conntrack modules sqlnet
set system conntrack modules tftp
set system domain-name 'lan'
set system domain-search domain 'lan'
set system domain-search domain 'snow-char.ts.net'
set system host-name 'vyos'
set system ipv6 disable-forwarding
set system login banner post-login ''
set system login user vyos authentication public-keys mac key 'AAAAB3NzaC1yc2EAAAADAQABAAABgQDdcFMG8+XBsiPAdofnG9o4GIIV5N9NkgfVtDOELRTcFt1qOUuDZe7JKsdE+DnfMvSrvdPBgkKORfOd8tq7sus7WiXwbOzNXxYKrqpzLJQu43NFDee9srIDZSG1vN0cY0GgRGMOqOQ+Ys8eqrBKP9/0WtabOcCQVGqhAJ/wrRrZ64YhP4VFXlUIS+/WfWBKh8RfSbVeAtCWxCPiNHnpcYmmboxhA9k57HWqsHm75wJZyHOxDElRR4mBTtY0kfcVCLHfGaaLkzEQPjMgRVWIUGnWjPRwPnIlle9W6Busu+u73MTyxq/+Yi43nCE0EEhCbkkIOPl/wC+zm2skMwONAzZdgwI0zEDlvC7TKS4KVzTajGJWORfb8l/yUhMubu7YUv/xA3k+xa+l0RVIFcfc6ZxTyAbFsg4Yi+47204HdePh3AhIGU1yJmCldGZ6RR5QGylhRUnOnQWIsDmhGMMaASz9LRbyxc7O/fOWhGL8+VSJfRd7xsEdtFBKQMldWZNgPI8='
set system login user vyos authentication public-keys mac type 'ssh-rsa'
set system login user vyos authentication public-keys nas key 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC7HK73pZDvLzbz9tfXbUlPJIIdL2BqViv6k9AT843gt43klkUkEAnokcc/nGuPkEPMdrovnW5RQZrcMydJFWVZad3x0pw4TaUHmS5eDK8HiZ7nlln2NXR/PllgDgiRs3Nqia8mBg2QgyJMUoWwSlcWDKnm5SfTdeuqGXy4T97Rpk7GReVPcmS1KyWt96LHKCZ7LXq2W/EwKvlPoAADTiukqk/0pq1wOTfCRqxqrNi55vi3HhQ5iXJ/gZ+zi7jGSxnbkLdyb3nZKhehpJDLKHCdK9jaJuTMiLugaqNLNGE10CPXjalIbuah1bz+4pFYT7n+FskYuL8uMo0/wTvn9Dnf'
set system login user vyos authentication public-keys nas type 'ssh-rsa'
set system name-server '1.1.1.1'
set system name-server '1.0.0.1'
set system syslog global facility all level 'info'
set system syslog global facility local7 level 'debug'
set system time-zone 'Europe/Budapest'
