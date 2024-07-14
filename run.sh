#!/bin/bash

function get_apk_info() {
    local apk_path="$1"

    if [[ ! -f "$apk_path" ]]; then
        echo "APK file not found: $apk_path"
        exit 1
    fi

    local badging_info=$(aapt dump badging "$apk_path")

    package_name=$(echo "$badging_info" | grep "package: name=" | awk -F"'" '{print $2}')
    version_code=$(echo "$badging_info" | grep "package: name=" | awk -F"'" '{print $6}')

    parent_path=$(dirname "$apk_path")/$package_name
    file_name=$(basename "$apk_path")
    dist_path="$parent_path/dist/$file_name"

    echo "Package Name: $package_name"
    echo "Version Name: $version_code"
    echo "Parent Path: $parent_path"
    echo "File Name: $file_name"
}

decode() {
    local apk_path="$1"
    java -jar $HOME/.apklab/apktool_2.9.3.jar d "$apk_path" -o "$parent_path" --only-main-classes
    cd $parent_path && git init
    echo $'/build\n/dist' >$parent_path/.gitignore
    git add .
    git commit -m "init project"
    subl $parent_path
}

sign_and_install() {
    java -jar $HOME/.apklab/apktool_2.9.3.jar b "$parent_path" --use-aapt2
    java -jar $HOME/.apklab/uber-apk-signer-1.3.0.jar -a "$dist_path" --allowResign --overwrite
    adb install -r "$dist_path"
}

save_patch() {
    mkdir -p $package_name
    git --git-dir "$parent_path/.git" show --pretty="" > "$package_name/$version_code.patch"
}

prompt_user() {
    while true; do
        read -p "Build app? (yes/no): " user_input
        case "$user_input" in
        [Yy][Ee][Ss] | [Yy])
            sign_and_install
            Echo Installing apk...
            ;;
        [Nn][Oo] | [Nn])
            echo Saving patch...
            save_patch
            echo Done!
            break
            ;;
        *)
            echo "Invalid input. Please enter yes or no."
            ;;
        esac
    done
}

main() {
    # read -p "Enter the path of the APK file: " apk_file_path
    echo 'Getting Apk Info ...'
    get_apk_info "$1"
    
    echo 'Decode Apk'
    # decode "$apk_file_path"

    prompt_user
}

main "$1"
