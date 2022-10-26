#!/bin/bash
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update

# install bind9
apt-get update
apt-get install bind9 -y

# nomor 5
# DNS Slave
echo 'zone "wise.d11.com" {
        type slave;
        masters { 192.190.2.2; }; // IP WISE
        file "/var/lib/bind/wise.d11.com";
};' > /etc/bind/named.conf.local
service bind9 restart

# nomor 6

echo "options {
        directory \"/var/cache/bind\";
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

# Zone operation.wise.d11.com
echo 'zone "wise.d11.com" {
        type slave;
        masters { 192.190.2.2; }; // IP WISE
        file "/var/lib/bind/wise.d11.com";
};

zone "operation.wise.d11.com"{
        type master;
        file "/etc/bind/operation/operation.wise.d11.com";
};'> /etc/bind/named.conf.local

mkdir /etc/bind/operation

# konfigurasi subdomain www.operation.wise.d11.com
echo "\$TTL    604800
@       IN      SOA     operation.wise.d11.com. root.operation.wise.d11.com. (
                        202210261       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      operation.wise.d11.com.
@               IN      A       192.190.3.3       ; IP EDEN
www             IN      CNAME   operation.wise.d11.com." > /etc/bind/operation/operation.wise.d11.com

service bind9 restart

# Nomor 7
# konfigurasi subdomain www.strix.operation.wise.d11.com
echo "\$TTL    604800
@       IN      SOA     operation.wise.d11.com. root.operation.wise.d11.com. (
                        202210261       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      operation.wise.d11.com.
@               IN      A       192.190.3.3       ; IP EDEN
www             IN      CNAME   operation.wise.d11.com.
strix           IN      A       192.190.3.3       ; IP EDEN
www.strix       IN      CNAME   strix.operation.wise.d11.com." > /etc/bind/operation/operation.wise.d11.com

service bind9 restart
