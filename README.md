# trojan

[trojan](https://github.com/trojan-gfw/trojan) docker image

```
docker pull cntrump/ubuntu-trojan:1.15.1
```

Run trojan server

```
docker run -it --rm \
           -p 443:443 \
           -v /usr/local/etc/trojan/config.json:/usr/local/etc/trojan/config.json \
           cntrump/ubuntu-trojan:1.15.1
```
