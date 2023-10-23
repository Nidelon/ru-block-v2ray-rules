# ru-block-v2ray-rules
## Алярма
https://github.com/Chocolate4U/Iran-v2ray-rules/ - Основа, которую я использовал

## Что это?
Список GeoIP и GeoSite для v2ray, xray, ну или же для 3x-ui.
Делал для прокси WARP под свои нужды.

https://antifilter.download/ - Списки блокировок.

## Как использовать?
Ввести в консоль:
```
sudo rm -rf /usr/local/x-ui/bin/geosite_RU.dat && sudo curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geosite.dat -o /usr/local/x-ui/bin/geosite_RU.dat && sudo chmod 744 /usr/local/x-ui/bin/geosite_RU.dat
sudo rm -rf /usr/local/x-ui/bin/geoip_RU.dat && sudo curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geoip.dat -o /usr/local/x-ui/bin/geoip_RU.dat && sudo chmod 744 /usr/local/x-ui/bin/geoip_RU.dat
```

После в `sudo crontab -e` добавить следующее:
```
0 1 * * * rm -rf /usr/local/x-ui/bin/geosite_RU.dat && curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geosite.dat -o /usr/local/x-ui/bin/geosite_RU.dat && chmod 744 /usr/local/x-ui/bin/geosite_RU.dat
0 1 * * * rm -rf /usr/local/x-ui/bin/geoip_RU.dat && curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geoip.dat -o /usr/local/x-ui/bin/geoip_RU.dat && chmod 744 /usr/local/x-ui/bin/geoip_RU.dat
```
Я не уверен что задача в cron будет работать, пока сделал на первое время, позже переделаю под задачу в systemctl.

Далее можно вписать список в любые правила, например в маршрутизацию:
```
[
  {
    "type": "field",
    "inboundTag": [
      "api"
    ],
    "outboundTag": "api"
  },
  {
    "type": "field",
    "outboundTag": "WARP",
    "domain": [
      "ext:geosite_RU.dat:ru-block"
    ],
    "ip": [
      "ext:geoip_RU.dat:ru-block"
    ]
  }
]
```
![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/16c0215f-568d-44bb-9202-fc39eb695154)

