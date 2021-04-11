# what

debian:buster に testing の nginx 1.18 と more_clear_headers を入れる Dockerfile

debian:buster の nginx は 1.14 である。どうにか楽して nginx の stable である 1.18 を入れたい。しかも more_clear_headers を使いたい。ふと debian の testing の nginx を見ると 1.18 である。

* https://packages.debian.org/ja/buster/libnginx-mod-http-headers-more-filter
* https://packages.debian.org/ja/bullseye/libnginx-mod-http-headers-more-filter

debian のパッケージシステムを調整することで、 buster に testing のパッケージをイントスールできる。

* https://debimate.jp/2019/03/09/debian-%E4%BB%BB%E6%84%8F%E3%81%AEtesting-unstable%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E3%81%BF%E3%82%92install%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95%E3%82%B7%E3%82%B9%E3%83%86/

more_clear_headers さえ気にしなければ、nginx公式のdebを使えた。

* http://nginx.org/en/linux_packages.html#Debian

build は強行できた。しかし run したときの影響は未知数。

nginx/testing が依存してる libcrypt1/testing というやつが buster になく、 libcrypt1/testing が testing の libc6/testing に依存している。

# how to run

```
$ docker build -t debian-nginx:buster-1.18 .
$ docker run -itd -p 8080:80 debian-nginx:buster-1.18
$ curl http://localhost:8080
```
