# `cli-pipe`

Installs essential text-processing CLI tools used in shell pipelines.

## Installs

| CLI   | macOS | Debian |
| ----- | ----- | ------ |
| `awk` | —     | `apt`  |
| `sed` | —     | `apt`  |
| `jq`  | —     | `apt`  |

## Notes

- macOS ships with `awk` and `sed` built-in; this package is Debian-only.
- Invoke via `make ubuntu-cli-pipe`.
