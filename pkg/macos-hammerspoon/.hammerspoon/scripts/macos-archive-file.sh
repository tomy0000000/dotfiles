#!/bin/bash
set -euo pipefail

declare -r DAYS_TOO_OLD=7
declare -r -a MOVE_DENYLIST=(
    ".dbxignore"
	".DS_Store"
	".localized"
	".Trash"
	".TemporaryItems"
	".fseventsd"
	".Spotlight-V100"
	".com.apple.timemachine.supported"
    "Long Term Memories"
)

is_in_denylist() {
	local input="${1:-}"
	if [[ -z "$input" ]]; then
		return 1
	fi

	local name="$input"
	if [[ -e "$input" ]]; then
		name="$(basename "$input")"
	fi

	for deny in "${MOVE_DENYLIST[@]}"; do
		if [[ "$name" == "$deny" ]]; then
			return 0
		fi
	done

	return 1
}

is_alias() {
    local path="${1:-}"
    if [[ -z "$path" || ! -e "$path" ]]; then
        return 1
    fi

	# Symlink files are aliases
	if [[ -L "$path" ]]; then
		return 0
	fi

	# macOS Finder alias files have UTI 'com.apple.alias-file'
	local uti
	uti="$(mdls -raw -name kMDItemContentType "$path" 2>/dev/null || true)"
	if [[ "$uti" == "com.apple.alias-file" ]]; then
		return 0
	fi

	# Sometimes the alias UTI appears in the content type tree
	local uti_tree
	uti_tree="$(mdls -raw -name kMDItemContentTypeTree "$path" 2>/dev/null || true)"
	if echo "$uti_tree" | grep -q "com.apple.alias-file"; then
		return 0
	fi

	# Fallback: use 'file' output to detect alias wording (not always present)
	if file "$path" 2>/dev/null | grep -qi "alias"; then
		return 0
	fi

	return 1
}

is_tagged() {
	local path="${1:-}"
	if [[ -z "$path" || ! -e "$path" ]]; then
		return 1
	fi

	local raw
	raw="$(mdls -raw -name kMDItemUserTags "$path" 2>/dev/null || true)"
	if [[ -n "$raw" && "$raw" != "(null)" ]]; then
		return 0
	fi

	return 1
}

movable() {
	local path="${1:-}"
	if [[ -z "$path" || ! -e "$path" ]]; then
		# Not movable if path missing
		return 1
	fi

    # Denylist items are not movable
	if is_in_denylist "$path"; then
		return 1
	fi

	# Aliases/symlinks are not movable
	if is_alias "$path"; then
		return 1
	fi

	# Tagged files are not movable
	if is_tagged "$path"; then
		return 1
	fi

	return 0
}

is_too_old() {
    local path="${1:-}"
	local days_threshold="$DAYS_TOO_OLD"

    if [[ -z "$path" || ! -e "$path" ]]; then
        return 1
    fi

    local mod_time
    mod_time=$(stat -f "%m" "$path")
    local current_time
    current_time=$(date +%s)
    local age_days=$(( (current_time - mod_time) / 86400 ))

    if (( age_days > days_threshold )); then
        return 0
    else
        return 1
    fi
}

archive_to_dir() {
	local src="${1:-}"
	local dest="${2:-}"
	local predicate="${3:-}"

	if [[ -z "$src" || -z "$dest" ]]; then
		echo "Usage: archive_to_dir <src> <dest>" >&2
		return 2
	fi

	if [[ ! -d "$src" ]]; then
		echo "Source folder not found: $src" >&2
		return 1
	fi

	mkdir -p "$dest"

	shopt -s nullglob dotglob
	local moved_any=false
	for item in "$src"/*; do
		if ! movable "$item"; then
			continue
		fi

		if [[ -n "$predicate" ]] && declare -F "$predicate" >/dev/null; then
			if ! "$predicate" "$item"; then
				continue
			fi
		fi

		mv -n "$item" "$dest"/
            printf "%s\t\t\tmoved to %s\n" "$(basename "$item")" "$dest"
		moved_any=true
	done
	shopt -u dotglob nullglob

	if [[ "$moved_any" == false ]]; then
		echo "No items to move from $src"
	fi
}

main() {
    local db_doc="$HOME/Dropbox/Documents"
    local db_ltm="$HOME/Dropbox/Documents/Long Term Memories"

	archive_to_dir "$HOME/Desktop" "$db_doc"
	archive_to_dir "$HOME/Downloads" "$db_doc"
	archive_to_dir "$db_doc" "$db_ltm" "is_too_old"
}

# Run main only when executed directly (not when sourced)
if [[ "${BASH_SOURCE[0]:-}" == "$0" ]]; then
	main "$@"
fi

