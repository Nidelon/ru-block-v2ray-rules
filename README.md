# ru-block-v2ray-rules
[![Generate v2ray routing rules](https://github.com/Nidelon/ru-block-v2ray-rules/actions/workflows/release.yml/badge.svg)](https://github.com/Nidelon/ru-block-v2ray-rules/actions/workflows/release.yml)
## Что это?
Список блокировок Роскомнадзора в GeoIP и GeoSite для v2ray, xray, ну или же для 3x-ui.
Делал для прокси WARP под свои нужды.

https://antifilter.download/ - Списки блокировок которые используются.

## Как использовать?
### Если установлен
Использовать правило `"ext:geosite_RU.dat:ru-block"` для сайтов или `"ext:geoip_RU.dat:ru-block"` для ip адресов.

### Если не установлен, то инструкция с авто-апдейтом для 3x-ui
Ввести в консоль:
```
sudo rm -rf /usr/local/x-ui/bin/geosite_RU.dat && sudo curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geosite.dat -o /usr/local/x-ui/bin/geosite_RU.dat && sudo chmod 744 /usr/local/x-ui/bin/geosite_RU.dat
sudo rm -rf /usr/local/x-ui/bin/geoip_RU.dat && sudo curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geoip.dat -o /usr/local/x-ui/bin/geoip_RU.dat && sudo chmod 744 /usr/local/x-ui/bin/geoip_RU.dat
```

После в `sudo crontab -e`, добавить следующее:
```
@daily rm -rf /usr/local/x-ui/bin/geosite_RU.dat && curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geosite.dat -o /usr/local/x-ui/bin/geosite_RU.dat && chmod 744 /usr/local/x-ui/bin/geosite_RU.dat
@daily rm -rf /usr/local/x-ui/bin/geoip_RU.dat && curl -sSL https://github.com/Nidelon/ru-block-v2ray-rules/raw/release/geoip.dat -o /usr/local/x-ui/bin/geoip_RU.dat && chmod 744 /usr/local/x-ui/bin/geoip_RU.dat
```
Алярма: Задача работает на удаление с последующей заменой, возможен вылет если xray или v2ray проверит файл в этот промежуток, позже исправлю скрипт.

Далее можно вписать список в любые правила, например в маршрутизацию WARP:
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

## TODO
Сделать список сайтов которые блокируют РФ пользователей. ("Как тестовый сделаю на `"ext:geosite_RU.dat:blocked_by_site"`)

## Алярма
https://github.com/Chocolate4U/Iran-v2ray-rules/ - Основа, которую я переписал, упростив её.
