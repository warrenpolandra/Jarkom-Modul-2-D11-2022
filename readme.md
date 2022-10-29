# Jarkom-Modul-2-D11-2022

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

## Nomor 6

1. Tambahkan konfigurasi delegasi subdomain yang mengarah ke Berlint pada file `/etc/bind/wise/wise.d11.com
2. Konfigurasi delegasi subdomain pada file /etc/bind/named.conf.options
3. Restart bind9 dan delegasi subdomain siap dipakai
