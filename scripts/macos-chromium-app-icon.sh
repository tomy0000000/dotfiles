#!/bin/bash

BASE_DIR="${HOME}/Applications/"
BROWSER_DIRS=("Chrome Apps.localized" "Brave Browser Apps.localized")

declare -a pids
declare -a app_paths

apply_icon() {
    fileicon set "${app_path}" "${icon_path}" >/dev/null
    return $?
}

main() {
    for icon_path in "${BASE_DIR}"/Icons/*.png; do
        app="$(basename "${icon_path}" .png)"
        for browser_dir in "${BROWSER_DIRS[@]}"; do
            app_path="${BASE_DIR}/${browser_dir}/${app}.app"
            if [ -d "${app_path}" ]; then
                apply_icon "${app_path}" "${icon_path}" &
                pid=$!
                pids+=("${pid}")
                app_paths+=("${app_path}")
            fi
        done
    done

    for index in "${!pids[@]}"; do
        pid=${pids[$index]}
        app_path=${app_paths[$index]}
        wait "${pid}"
        exit_status=$?
        if [ $exit_status -ne 0 ]; then
            echo "Failed to apply icon to ${app_path}"
        else
            echo "Applied icon to ${app_path}"
        fi
    done
}

main
