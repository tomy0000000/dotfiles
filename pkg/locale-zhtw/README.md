# `locale-zhtw`

Installs and activates Traditional Chinese (Taiwan) locale on Debian-based systems.

## Installs

| Package   | macOS | Debian |
| --------- | ----- | ------ |
| `locales` | —     | `apt`  |

## Configures

- Generates `zh_TW` and `zh_TW.UTF-8` locales via `locale-gen`
- Sets system-wide `LANG=zh_TW.UTF-8` and `LANGUAGE=zh_TW` via `update-locale`

## Notes

- macOS does not need this package — locale support is built-in via System Settings
- Invoked as part of `ubuntu-essential`, so it runs early in the Ubuntu bootstrap
