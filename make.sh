#!/bin/bash



BIN_TARGETS="olpkgmgr-create"

case $1 in
    build)
        ### Make directories
        mkdir -p build/bin dist
        ### Combining files
        for binname in $BIN_TARGETS; do
            echo "[INFO] Building target '$binname'"
            binfn="build/bin/$binname"
            find "src/$binname" -type f | sort | while read -r fn; do
                cat "$fn"
            done > "$binfn"
        done
        ;;
    install_local)
        find build/bin -type f | while read -r binfn; do
            sudo install --verbose -m755 "$binfn" "/usr/local/bin/$(basename "$binfn")"
        done
        ;;
    easy)
        bash "$0" build
        bash "$0" install_local
        ;;
esac
