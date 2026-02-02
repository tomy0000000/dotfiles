# shellcheck disable=SC2148
# distro.sh — detect current OS/distro identifier (ubuntu, macos, arch, etc.)

# Source guard: Exit if executed directly
(return 0 2>/dev/null) || exit 0

# Idempotent import: Prevent multiple imports
[ "${__DISTRO_SH_LOADED:-}" = "1" ] && return 0
__DISTRO_SH_LOADED=1

# --- Public API --------------------------------------------------------------

distro() {
  case "$(uname)" in
    Linux)
      distro_name=$(
        # shellcheck source=/dev/null
        . /etc/os-release
        echo "${NAME}"
      )
      case $distro_name in
        "Ubuntu")
          printf '%s' "ubuntu"
          ;;
        "Arch Linux")
          printf '%s' "arch"
          ;;
        "CentOS Linux")
          printf '%s' "cent"
          ;;
        "Debian GNU/Linux")
          printf '%s' "debian"
          ;;
        "Fedora")
          printf '%s' "fedora"
          ;;
        *)
          printf '%s' "linux"
          ;;
      esac
      ;;
    Darwin)
      printf '%s' "macos"
      ;;
  esac
}
