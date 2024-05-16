# ru-block-v2ray-rules
[![Generate v2ray routing rules](https://github.com/Nidelon/ru-block-v2ray-rules/actions/workflows/release.yml/badge.svg)](https://github.com/Nidelon/ru-block-v2ray-rules/actions/workflows/release.yml)

## ⚠️ Предупреждение ⚠️
Так как я начал использовать Aeza для vpn, то итоговая скорость выходит быстрее и стабильнее чем у этого костыля.
Кто захочет, может использовать мою [рефералку](https://aeza.net/?ref=450474) с бонусом пополнения баланса на 15%.
Сам же он с поддержкой Outline и Wireguard за 212 руб. в месяц.

## Что это?
Список блокировок Роскомнадзора в GeoIP и GeoSite для xray или любого другого маршрутизатора трафика принимающего geosite файлы.
Делал для прокси WARP в x3-ui под свои нужды.

https://antifilter.download/ - Списки блокировок которые используются.

## Как использовать?

<details>
<summary>Если уже установлен</summary>

Использовать правило `ext:geosite_RU.dat:ru-block` для сайтов или `ext:geoip_RU.dat:ru-block` для ip адресов.
</details>

<details>
<summary>Если не установлен, то инструкция с авто-апдейтом для 3x-ui</summary>

Заранее предупреждаю, что инструкция была написана на скорую руку, и возможно будет необходимо заменить шаблон WARP (см. Возможные проблемы).

Установить [3x-ui](https://github.com/MHSanaei/3x-ui?tab=readme-ov-file#install--upgrade) и [WARP](https://github.com/MHSanaei/3x-ui?tab=readme-ov-file#warp-configuration)

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

Далее все действия выполняем в настройках Xray. ![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/9cc4c275-73da-4445-bae1-618e2b9cddaa)

Переходим в базовые шаблоны и в основные шаблоны.
Обязательно нужно выставить IPIfNonMatch в настройка стратегии маршрутизации доменов для того что-бы обход работал.

![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/36d5da06-09a8-4ffa-8969-8c816e715d4a)

Далее там же, во вкладке "Настройки WARP" нажимаем на "WARP Исходящий".

![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/f243ccd4-bad1-4eb8-a6e8-72fa996e0d8f)

В появившемся окне нажимаем "Далее", "Информация" и после "Добавить исходящий".

![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/c151c707-4865-4027-af8d-7c123c5330d8)


![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/f9acc755-f67f-4e66-a646-939409d34a6e)

Переходим в "Правила маршрутизации" и нажимаем "Добавить правило".

![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/7c2329d5-fe59-4cdd-bd42-837cd7590438)

В списке "Outbound Tag" выбираем "warp", в IP вписываем "ext:geoip_RU.dat:ru-block" (Без кавычек), в Domain "ext:geosite_RU.dat:ru-block".

![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/4752e6b8-7e43-4a2f-849e-8feb3e50eb99)

Нажимаем да, сохраняем настройки и перезапускаем xray.

</details>

## Возможные проблемы.

<details>
<summary>Не проксируется трафик через WARP.</summary>

Сначало обновите [WARP](https://github.com/MHSanaei/3x-ui?tab=readme-ov-file#warp-configuration) до новой версии.

Если после установки не хочет работать, можно попробовать заменить конфиг WARP на другой.

В настройках xray перейти в расширенные шаблоны и в исходящие.

![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/95a1a15a-6560-44e7-9908-0b3a9d8f9232)

Найти правило warp.

![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/1139460c-d560-422c-a4e6-4e3c50d88a53)

И заменить его на следующее:

```
  {
    "tag": "WARP",
    "protocol": "socks",
    "settings": {
      "servers": [
        {
          "address": "127.0.0.1",
          "port": 40000
        }
      ]
    }
  }
```

![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/7196ff51-172b-4e98-ad0b-08a8a8d91925)

После поменять "Outbound Tag" правила маршрутизации на WARP.

![image](https://github.com/Nidelon/ru-block-v2ray-rules/assets/48694850/0f18e828-01b8-4b03-a7ee-fc14421d2eb9)

</details>

<details>
<summary>Не пускает на сайты по типу OpenAI, или других запрещающие определенный регион.</summary>

Пока обхода не нашёл, самый простой вариант, просто купить сервер за границей и через него пропускать трафик.

</details>

## TODO
1. Исправить cron скрипт, при ошибке скачивания файлы удаляются.
2. Сделать генерацию geosite и geoip совместимых с sing-box, а также srs формат списков.

## Алярма
https://github.com/Chocolate4U/Iran-v2ray-rules/ - Основа, которую я переписал, упростив её.
