# `cli-pipe`

Installs essential text-processing CLI tools used in shell pipelines.

## Installs

| CLI   | macOS              | Debian |
| ----- | ------------------ | ------ |
| `awk` | `brew` (as `gawk`) | `apt`  |
| `sed` | `brew` (as `gsed`) | `apt`  |
| `jq`  | `brew`             | `apt`  |
| `yq`  | `brew`             | —      |

## Notes

- macOS ships BSD `awk` / `sed`. The GNU versions land as `gawk` and `gsed` (PATH-unshadowed) to keep BSD defaults.
