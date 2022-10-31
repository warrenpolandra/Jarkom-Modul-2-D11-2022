# Jarkom-Modul-2-D11-2022

## Nomor 1

topologi dibuat sesuai gambar yang ada pada gambar soal shift

IP Address dari masing-masing node adalah:

    - Ostania	: 192.190.1.1	| Router
    - SSS		: 192.190.1.2	| Client
    - Garden	: 192.190.1.3	| Client
    - WISE		: 192.190.2.2	| DNS Master
    - Berlint	: 192.190.3.2	| DNS Slave
    - Eden		: 192.190.3.3	| Web Server

## Nomor 2

1. Pertama install update dan bind9 terlebih dahulu
2. Kemudian buat zone baru `wise.d11.com` dengan type master sebagai DNS Master, dan dipindahkan ke file `/etc/bind/named.conf.local`
3. Buat folder baru dengan alamat `/etc/bind/wise`
4. Untuk membuat alias `www.wise.d11.com` dapat ditambahkan dengan konfigurasi di file `/etc/bind/wise/wise.d11.com`
5. Restart bind9 sehingga DNS Master serta aliasnya sudah dibuat

## Nomor 3

1. Pada konfigurasi DNS Master Wise, dapat ditambahkan IP address dari EDEN dan alamat aliasnya yang akan mengarah ke Eden
2. Restart bind9 pada DNS Master

## Nomor 4

1. Tambahkan zone reverse DNS pada file /etc/bind/named.conf.local
2. Tambahkan reverse DNS (NS dan PTR) pada file /etc/bind/wise/2.190.192.in-addr.arpa
3. Restart bind9 dan reverse DNS sudah siap dipakai

## Nomor 5

1. Ubah zone `wise.d11.com` agar dapat me-notify Berlint di file `/etc/bind/named.conf.local`
2. Restart bind9 dan konfigurasi untuk DNS Master sudah selesai
3. pada wise melakukan konfigurasi pada named.conf.local kita nambahin notify yes; 
        also-notify {192.190.3.2;};  //Masukan IP Berlint tanpa tanda petik
        allow-transfer {192.190.3.2;}; // Masukan IP Berlint tanpa tanda petik
        setelah itu melakukan restart menggunakan service bind9 restart
mengarahkan berlint ke router `nameserver 192.168.122.1` kemudian melakukan update dan install bind9 -y, setelah itu kita menggunkan konfigurasi pada file /etc/bind/named.conf.local, setelah itu melakukan restart, kemudian kite ke wise lagi dan menghentikan wise dengan service bind9 stop kemudian ke client ke sss atau garden dan melakukan ping pada wise.d11.com 

## Nomor 6

1. Tambahkan konfigurasi delegasi subdomain yang mengarah ke Berlint pada file `/etc/bind/wise/wise.d11.com
2. Konfigurasi delegasi subdomain pada file /etc/bind/named.conf.options
3. Restart bind9 dan delegasi subdomain siap dipakai
4. Pada file `/etc/bind/wise/wise.d11.com` melakukan konfigurasi dengan menambahkan ns1             IN      A       192.190.3.2; IP Berlint
operation           IN      NS      ns1
setelah itu membuka file `/etc/bind/named.conf.options` dan menambahkan ` allow-query{any;};` setelah itu membuka file `/etc/bind/named.conf.local` dan mengcoment ` //notify yes;
        //also-notify {192.190.3.2;};`
setelah itu melakukan restart, kemudian kita ke berlint pada berlint ini kita melakukan membuka file `/etc/bind/named.conf.options` kita tambahkan ` allow-query{any;};` setelah itu ke file ` /etc/bind/named.conf.local` disini kita menambahkan `zone "operation.wise.d11.com"{
        type master;
        file "/etc/bind/operation/operation.wise.d11.com";
};` setelah itu kita membuat file `mkdir /etc/bind/operation` 
kemudian membuka file `/etc/bind/operation/operation.wise.d11.com` menambahkan `@               IN      NS      operation.wise.d11.com.
@               IN      A       192.190.3.3       ;ip Eden
www             IN      CNAME   operation.wise.d11.com.`
setelah itu melakukan restart setelah itu melakukan ping `www.operation.wise.d11.com`  

## Nomor 7
1. membuka file `/etc/bind/operation/operation.wise.d11.com`membuka file tambahkan `strix         IN      A       192.190.3.3       ;IP Eden
www.strix     IN      CNAME   strix.operation.wise.d11.com.` setelah itu ke restart , kemudian melakukan ping `www.strix.operation.wise.d11.com`

## Nomor 8 

1. Untuk konfigurasi web server diperlukan instalasi update, apache, dan php

2. setelah itu konfigurasi server dibuat sesuai berikut dengan ServerName adalah `wise.d11.com` dan ServerAliasnya adalah `www.wise.d11.com` File ini disimpan dalam folder `/etc/apache2/sites-available/wise.d11.com`.

3. Kemudian file requirement untuk wise dipindahkan ke `var/www/wise.d11.com`

4. Setelah itu konfigurasi web server yang sudah dibuat di-enable dengan command `a2ensite wise.d11.com` dn

## Nomor 9

1. Dalam mengubah URL `www.wise.yyy.com/index.php/home` menjadi `www.wise.yyy.com/home`, module RewriteRule digunakan pada file `/var/www/wise.d11.com/.htaccess` untuk dapat mengakses file .php.

2. Tambahkan directory `/var/www/wise.d11.com` pada file `/etc/apache2/sites-available/wise.d11.com.conf`

3. Restart apache2 dan url .php seharusnya sudah terubah.

## Nomor 10

1. Tambahkan konfigurasi untuk alamat `eden.wise.d11.com` dengan serverAlias `www.eden.wise.d11.com` pada file `/etc/apache2/sites-available/eden.wise.d11.com.conf`

2. Gunakan `a2ensite eden.wise.d11.com` untuk mengaktifkan konfigurasi yang terlah dibuat

3. Restart apache2 dan konfigurasi web server sudah siap digunakan

## Nomor 11

1. Tambahkan directory `/var/www/eden.wise.d11.com/public` tanpa opsi `AllowOverride All` dan hanya dengan opsi `Options +Indexes` pada file `/etc/apache2/sites-available/eden.wise.d11.com.conf`

2. Restart apache2 dan konfigurasi web server sudah siap digunakan

## Nomor 12

1. Tambahkan konfigurasi ErrorDocument ddan diganti dengan halaman `/error/404.html` pada file `/etc/apache2/sites-available/eden.wise.d11.com.conf`

2. Restart apache2 dan konfigurasi web server sudah siap digunakan

## Nomor 13

1. Tambahkan konfigurasi Alias `/js` untuk mempersingkat url `/var/www/eden.wise.d11.com/public/js` pada file `/etc/apache2/sites-available/eden.wise.d11.com.conf`

2. Restart apache 2 dan konfigurasi web server sudah siap digunakan

## Nomor 14

1. Tambahkan konfigurasi web server dengan port 15000 dan 15500

2. Pada kedua konfigurasi tersebut, tambahkan serverName `strix.operation.wise.d11.com` dan serverAlias `www.strix.operation.wise.d11.com` dengan documentRoot `/var/www/strix.operation.wise.d11.com`

3. Enable konfigurasi web server tersebut dengan `a2ensite strix.operation.wise.d11.com`

4. Buat direktori baru `/var/www/strix.operation.wise.d11.com`

5. Copy resource file konfigurasi dari file `strix.operation.wise.d11.com`

6. Tambahkan port configuration pada file `/etc/apache2/ports.conf`

7. Restart apache2 dan konfigurasi web server sudah siap digunakan

## Nomor 15

1. Username dan password dapat ditambahkan dengan command `htpasswd -c -b /etc/apache2/.htpasswd Twilight opStrix`

2. Tambahkan authentication pada file `/var/www/strix.operation.wise.d11.com`

## Nomor 16

1. Pada file `/etc/apache2/sites-available/000-default.conf`, dapat digunakan `RewriteCond` dan `RewriteRule` yang diarahkan ke `www.wise.d11.com`

2. Restart apache2 dan konfigurasi webserver sudah siap digunakan

## Nomor 17

1. `RewriteCond` untuk segala request gambar yang memiliki substring `eden`

2. `RewriteRule` untuk mengarahkan request gambar menuju eden.png

3. Edit konfigurasi webserver untuk wise.d11.com

4. Restart apache2 dan konfigurasi webserver sudah siap digunakan

## Kendala yang dialami
- Salah satu anggota kami  tidak bisa menggunakan GNS 
