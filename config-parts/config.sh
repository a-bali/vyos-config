#!/bin/vbash

set container network containers prefix '192.168.100.0/24'
set container name nginx allow-host-networks
set container name nginx image 'docker.io/nginx:stable-alpine-slim'
set container name nginx volume nginx-config destination '/etc/nginx/conf.d'
set container name nginx volume nginx-config mode 'ro'
set container name nginx volume nginx-config source '/config/containers/nginx/conf'
set container name nginx volume nginx-data destination '/usr/share/nginx/html/'
set container name nginx volume nginx-data mode 'ro'
set container name nginx volume nginx-data source '/config/containers/nginx/data'
set container name pihole environment CORS_HOSTS value 'pihole,pihole.lan'
set container name pihole environment DNSMASQ_LISTENING value 'single'
set container name pihole environment FTLCONF_NAMES_FROM_NETDB value 'false'
set container name pihole environment PIHOLE_DNS_ value '1.1.1.1;1.0.0.1'
set container name pihole environment REV_SERVER value 'true'
set container name pihole environment REV_SERVER_CIDR value '192.168.0.0/16'
set container name pihole environment REV_SERVER_TARGET value '192.168.1.1'
set container name pihole environment TZ value 'Europe/Budapest'
set container name pihole environment WEBPASSWORD value 'pihole'
set container name pihole image 'docker.io/pihole/pihole:latest'
set container name pihole network containers address '192.168.100.100'
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

set interfaces ethernet eth0 address 'dhcp'
set interfaces ethernet eth0 description 'WAN'
set interfaces ethernet eth1 address '192.168.1.1/24'
set interfaces ethernet eth1 description 'LAN'
set interfaces loopback lo

set nat source rule 100 outbound-interface 'eth0'
set nat source rule 100 source address '192.168.0.0/16'
set nat source rule 100 translation address 'masquerade'
set nat source rule 110 outbound-interface 'tailscale0'
set nat source rule 110 source address '192.168.0.0/16'
set nat source rule 110 translation address 'masquerade'

set service dhcp-server host-decl-name
set service dhcp-server hostfile-update
set service dhcp-server shared-network-name LAN domain-name lan
set service dhcp-server shared-network-name LAN domain-search lan
set service dhcp-server shared-network-name LAN domain-search snow-char.ts.net
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 default-router '192.168.1.1'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 lease '10800'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 name-server '192.168.1.1'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 range 0 start '192.168.1.101'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 range 0 stop '192.168.1.240'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping openwrt1 ip-address '192.168.1.11'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping openwrt1 mac-address 'f4:f2:6d:9c:36:f7'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping openwrt2 ip-address '192.168.1.12'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping openwrt2 mac-address '28:ee:52:62:9d:5a'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping desktop ip-address '192.168.1.25'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping desktop mac-address 'd0:50:99:51:d4:8c'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping wled ip-address '192.168.1.30'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping wled mac-address '38:2b:78:04:2d:34'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping nas ip-address '192.168.1.200'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping nas mac-address 'd0:50:99:98:7f:df'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping alexa mac-address '1c:12:b0:5a:50:5d'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping alexa ip-address '192.168.1.31'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping tcltv mac-address '2c:e0:32:7e:23:de'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping tcltv ip-address '192.168.1.32'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping zigbeegw mac-address '90:38:0C:68:0D:43'
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 static-mapping zigbeegw ip-address '192.168.1.33'


set service monitoring telegraf prometheus-client port '9100'

set service dns forwarding allow-from '0.0.0.0/0'
set service dns forwarding domain snow-char.ts.net server 100.100.100.100
set service dns forwarding listen-address '192.168.1.1'
set service dns forwarding name-server 192.168.100.100

set system ntp listen-address '192.168.1.1'
set system ntp allow-clients address '0.0.0.0/0'
delete system ntp server
set system ntp server 0.pool.ntp.org
set system ntp server 1.pool.ntp.org
set system ntp server 2.pool.ntp.org

set service snmp community public authorization 'ro'
set service snmp community public network '192.168.0.0/16'
set service snmp listen-address 192.168.1.1 port '161'

set service ssh port 22
delete system console
set system config-management commit-revisions '100'
set system conntrack modules ftp
set system conntrack modules h323
set system conntrack modules nfs
set system conntrack modules pptp
set system conntrack modules sip
set system conntrack modules sqlnet
set system conntrack modules tftp

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
set system syslog global facility protocols level debug
set system syslog host 192.168.1.174 facility all level info
set system syslog host 192.168.1.174 facility all protocol tcp
set system syslog host 192.168.1.174 format octet-counted
set system syslog host 192.168.1.174 port 6000
set system time-zone 'Europe/Budapest'

set system static-host-mapping host-name pve.lan inet '192.168.1.2'
set system static-host-mapping host-name switch.lan inet '192.168.1.10'
set system static-host-mapping host-name vyos.lan alias 'pihole.lan'
set system static-host-mapping host-name vyos.lan alias 'vnstat.lan'
set system static-host-mapping host-name vyos.lan inet '192.168.1.1'

set system option performance latency

set firewall name WAN-IN default-action 'drop'
set firewall name WAN-IN enable-default-log
set firewall name WAN-IN rule 10 action 'accept'
set firewall name WAN-IN rule 10 state established 'enable'
set firewall name WAN-IN rule 10 state related 'enable'
set firewall name WAN-IN rule 10 description 'Accept established and related packets'
set firewall name WAN-LOCAL default-action 'drop'
set firewall name WAN-LOCAL enable-default-log
set firewall name WAN-LOCAL rule 10 action 'accept'
set firewall name WAN-LOCAL rule 10 state established 'enable'
set firewall name WAN-LOCAL rule 10 state related 'enable'
set firewall name WAN-LOCAL rule 10 description 'Accept established and related packets'
set firewall name WAN-LOCAL rule 20 action 'accept'
set firewall name WAN-LOCAL rule 20 source address '192.168.0.0/16'
set firewall name WAN-LOCAL rule 20 protocol 'icmp'
set firewall name WAN-LOCAL rule 20 description 'Accept ICMP from local subnet'
set firewall name WAN-LOCAL rule 30 action 'accept'
set firewall name WAN-LOCAL rule 30 source address '192.168.0.0/16'
set firewall name WAN-LOCAL rule 30 protocol 'igmp'
set firewall name WAN-LOCAL rule 30 description 'Accept IGMP from local subnet'
set firewall name WAN-LOCAL rule 40 action 'accept'
set firewall name WAN-LOCAL rule 40 protocol 'udp'
set firewall name WAN-LOCAL rule 40 destination port 41641
set firewall name WAN-LOCAL rule 40 description 'Accept Tailscale packets'
set interfaces ethernet eth0 firewall in name 'WAN-IN'
set interfaces ethernet eth0 firewall local name 'WAN-LOCAL'
set system conntrack tcp loose enable
