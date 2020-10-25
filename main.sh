#!/bin/sh

real_script() {
    echo $(realpath "$(dirname ${0})/${1}")
}

echo "🖥 Operating System: $(uname)"
if [ $(uname) = "Linux" ];
then
    distro=$(. /etc/os-release; echo $NAME)
    echo "🌐 Distribution: ${distro}"
    case $distro in
        "Ubuntu")
            sh $(real_script "ubuntu/install_zsh.sh")
            ;;
        "Arch Linux")
            echo "Arch Linux is not supported, abort."
            ;;
        "CentOS Linux")
            echo "CentOS is not supported, abort."
            ;;
        "Debian GNU/Linux")
            echo "Debian is not supported, abort."
            ;;
        "Fedora")
            echo "Fedora is not supported, abort."
            ;;
        *)
            echo "This distro is not supported, abort."
            ;;
    esac
elif [ $(uname) = "Darwin" ];
then
    echo "Testing, abort."
    exit
    sh $(real_script "macos/install_homebrew.sh")
else
    echo "This OS is not supported, abort."
fi
