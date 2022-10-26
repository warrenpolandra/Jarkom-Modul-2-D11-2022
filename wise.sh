#!/bin/bash

# IP DNS
echo "nameserver 192.168.122.1" > /etc/resolv.conf

# install bind9
apt-get update
apt-get install bind9 -y

# nomor 2
# zone wise.d11.com
echo 'zone "wise.d11.com" {
        type master;
        file "/etc/bind/wise/wise.d11.com";
};' 
> /etc/bind/named.conf.local

mkdir /etc/bind/wise

# nomor 2
# konfigurasi alias  www.wise.d11.com
echo "\$TTL    604800
@       IN      SOA     wise.d11.com. root.wise.d11.com. (
                        202210261       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.d11.com.
@               IN      A       192.190.2.2 ; IP WISE
www             IN      CNAME   wise.d11.com." > /etc/bind/wise/wise.d11.com

service bind9 restart

# nomor 3
# konfigurasi www.eden.wise.d11.com
echo "\$TTL    604800
@       IN      SOA     wise.d11.com. root.wise.d11.com. (
                        202210261       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.d11.com.
@               IN      A       192.190.2.2 ; IP WISE
www             IN      CNAME   wise.d11.com.
eden            IN      A       192.190.3.3 ; IP EDEN
www.eden        IN      CNAME   eden.wise.d11.com." > /etc/bind/wise/wise.d11.com

service bind9 restart

# nomor 4
# Reverse DNS
echo 'zone "wise.d11.com" {
        type master;
        file "/etc/bind/wise/wise.d11.com";
};

zone "2.190.192.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.190.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

echo "\$TTL    604800
@       IN      SOA     wise.d11.com. root.wise.d11.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
2.190.192.in-addr.arpa.   IN      NS      wise.d11.com.
2                       IN      PTR     wise.d11.com." > /etc/bind/wise/2.190.192.in-addr.arpa

service bind9 restart

# nomor 5
# notify DNS Slave (Berlint)
echo 'zone "wise.d11.com" {
        type master;
        notify yes;
        also-notify {192.190.3.2;}; // IP BERLINT
        allow-transfer {192.190.3.2;}; // IP BERLINT
        file "/etc/bind/wise/wise.d11.com";
};

zone "2.190.192.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.190.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

service bind9 restart

# nomor 6
# konfigurasi subdomain operation.wise.d11.com
echo "\$TTL    604800
@       IN      SOA     wise.d11.com. root.wise.d11.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@       IN      NS      wise.d11.com.
@               IN      A       192.190.3.3 ; IP EDEN
www             IN      CNAME   wise.d11.com.
eden           IN      A       192.190.3.3 ; IP EDEN
www.eden       IN      CNAME   eden.wise.d11.com.
ns1             IN      A       192.190.3.2; IP BERLINT
operation           IN      NS      ns1" > /etc/bind/wise/wise.d11.com

# delegasi subdomain
echo "options {
        directory \"/var/cache/bind\";

        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

service bind9 restart
