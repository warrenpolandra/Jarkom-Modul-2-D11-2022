#!/bin/bash
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install bind9 -y

echo 'zone "wise.d11.com" {
type master;
file "/etc/bind/wise/wise.d11.com";
};'

# nomor 2
echo 'zone "wise.d11.com" {
        type master;
        file "/etc/bind/wise/wise.d11.com";
};' > /etc/bind/named.conf.local
mkdir /etc/bind/wise
echo "
\$TTL    604800
@       IN      SOA     wise.d11.com. root.wise.d11.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.d11.com.
@               IN      A       192.190.1.2 ; IP Wise
www             IN      CNAME   wise.d11.com.
" > /etc/bind/wise/wise.d11.com
service bind9 restart

# nomor 3
echo "
\$TTL    604800
@       IN      SOA     wise.d11.com. root.wise.d11.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.d11.com.
@               IN      A       192.190.1.2 ; IP Wise
www             IN      CNAME   wise.d11.com.
eden            IN      A       192.190.3.3 ; IP Eden
www.eden        IN      CNAME   eden.wise.d11.com.
" > /etc/bind/wise/wise.d11.com
service bind9 restart

# nomor 4

echo '
zone "wise.d11.com" {
        type master;
        file "/etc/bind/wise/wise.d11.com";
};

zone "2.172.192.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.172.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

echo "
\$TTL    604800
@       IN      SOA     wise.d11.com. root.wise.d11.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
2.172.192.in-addr.arpa.   IN      NS      wise.d11.com.
2                       IN      PTR     wise.d11.com.
"> /etc/bind/wise/2.172.192.in-addr.arpa
service bind9 restart


# nomor 5

echo '
zone "wise.d11.com" {
        type master;
        notify yes;
        also-notify {192.190.3.2;};  //Masukan IP Berlint tanpa tanda petik
        allow-transfer {192.190.3.2;}; // Masukan IP Berlint tanpa tanda petik
        file "/etc/bind/wise/wise.d11.com";
};

zone "2.172.192.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.172.192.in-addr.arpa";
};' > /etc/bind/named.conf.local
service bind9 restart

# nomor 6
echo "
\$TTL    604800
@       IN      SOA     wise.d11.com. root.wise.d11.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@       IN      NS      wise.d11.com.
@               IN      A       192.190.3.3 ; IP Eden
www             IN      CNAME   wise.d11.com.
eden           IN      A       192.190.3.3 ; IP Eden
www.eden       IN      CNAME   eden.wise.d11.com.
ns1             IN      A       192.190.3.2; IP Berlint
operation           IN      NS      ns1
"> /etc/bind/wise/wise.d11.com

echo "
options {
        directory \"/var/cache/bind\";

        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
" > /etc/bind/named.conf.options

echo '
zone "wise.d11.com" {
        type master;
        //notify yes;
        //also-notify {192.190.3.2;};  Masukan IP Berlint tanpa tanda petik
        file "/etc/bind/wise/wise.d11.com";
        allow-transfer {192.190.3.2;}; // Masukan IP Berlint tanpa tanda petik
};

zone "2.172.192.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.172.192.in-addr.arpa";
};
' >  /etc/bind/named.conf.local

service bind9 restart
}

Berlint(){
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update

# nomor 5
apt-get update
apt-get install bind9 -y
echo '
zone "wise.d11.com" {
        type slave;
        masters { 192.190.1.2; }; // Masukan IP Wise tanpa tanda petik
        file "/var/lib/bind/wise.d11.com";
};
' > /etc/bind/named.conf.local
service bind9 restart

# nomor 6

echo "
options {
        directory \"/var/cache/bind\";
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
" > /etc/bind/named.conf.options
echo '
zone "wise.d11.com" {
        type slave;
        masters { 192.190.1.2; }; // Masukan IP Wise tanpa tanda petik
        file "/var/lib/bind/wise.d11.com";
};

zone "operation.wise.d11.com"{
        type master;
        file "/etc/bind/operation/operation.wise.d11.com";
};
'> /etc/bind/named.conf.local
mkdir /etc/bind/operation
echo "
\$TTL    604800
@       IN      SOA     operation.wise.d11.com. root.operation.wise.d11.com. (
                                2      ; Serial
                        604800         ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
@               IN      NS      operation.wise.d11.com.
@               IN      A       192.190.3.3       ;ip Eden
www             IN      CNAME   operation.wise.d11.com.
" > /etc/bind/operation/operation.wise.d11.com
service bind9 restart


# Nomor 7
echo "
\$TTL    604800
@       IN      SOA     operation.wise.d11.com. root.operation.wise.d11.com. (
                                2      ; Serial
                        604800         ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
@               IN      NS      operation.wise.d11.com.
@               IN      A       192.190.3.3       ;ip Eden
www             IN      CNAME   operation.wise.d11.com.
strix         IN      A       192.190.3.3       ;IP Eden
www.strix     IN      CNAME   strix.operation.wise.d11.com.
" > /etc/bind/operation/operation.wise.d11.com
service bind9 restart
