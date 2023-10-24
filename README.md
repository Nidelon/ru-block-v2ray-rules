# ru-block-v2ray-rules

## Что это?
Список GeoIP и GeoSite для v2ray, xray, ну или же для 3x-ui.
Делал для прокси WARP под свои нужды.

https://antifilter.download/ - Списки блокировок.

## Как использовать?
### Если установлен
Использовать правило `"ext:geosite_RU.dat:ru-block"` для сайтов и `"ext:geoip_RU.dat:ru-block"` для ip адресов

### Если не установлен, то инструкция с авто-апдейтом для 3x-ui
Ввести в консоль:
```
sudo rm -rf /usr/local/x-ui/bin/geosite_RU.dat && sudo curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geosite.dat -o /usr/local/x-ui/bin/geosite_RU.dat && sudo chmod 744 /usr/local/x-ui/bin/geosite_RU.dat
sudo rm -rf /usr/local/x-ui/bin/geoip_RU.dat && sudo curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geoip.dat -o /usr/local/x-ui/bin/geoip_RU.dat && sudo chmod 744 /usr/local/x-ui/bin/geoip_RU.dat
```

После в `sudo crontab -e` добавить следующее:
```
0 12 * * * rm -rf /usr/local/x-ui/bin/geosite_RU.dat && curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geosite.dat -o /usr/local/x-ui/bin/geosite_RU.dat && chmod 744 /usr/local/x-ui/bin/geosite_RU.dat
0 12 * * * rm -rf /usr/local/x-ui/bin/geoip_RU.dat && curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geoip.dat -o /usr/local/x-ui/bin/geoip_RU.dat && chmod 744 /usr/local/x-ui/bin/geoip_RU.dat
```
Я не уверен что задача в cron будет работать, пока сделал на первое время, позже переделаю под задачу в systemctl.
UPD: Работает, кто хочет, может поменять 12 на любой час, либо же поменять на `30 * * * *`, только есть риск что xray не понравится если в промежутке не будет файла, что позже поправлю.

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

## Алярма
https://github.com/Chocolate4U/Iran-v2ray-rules/ - Основа, которую я использовал, но упростив её как можно сильнее.
