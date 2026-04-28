# `cli-network`

Network diagnostic and inspection tools for both macOS and Debian-based systems.

## Installs

| CLI          | macOS                   | Debian                    |
| ------------ | ----------------------- | ------------------------- |
| `ip`         | `brew` (iproute2mac)    | `apt` (iproute2)          |
| `nc`         | `brew` (netcat)         | `apt` (netcat-traditional)|
| `nmap`       | `brew`                  | `apt`                     |
| `ftp`        | `brew` (inetutils)      | built-in                  |
| `telnet`     | `brew` (inetutils)      | `apt`                     |
| `dig`        | built-in                | `apt` (dnsutils)          |
| `ifconfig`   | built-in                | `apt` (net-tools)         |
| `ping`       | built-in                | `apt` (iputils-ping)      |
| `traceroute` | built-in                | `apt`                     |

## Configures

None — this package only installs CLIs.

## Notes

- On macOS, `iproute2mac` provides a partial `ip` shim so the same commands work cross-platform; it does not implement every Linux `ip` subcommand.
- `dig`, `ifconfig`, `ping`, and `traceroute` are already present on macOS and therefore only installed on Debian.
