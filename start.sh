#!/bin/bash

# Update
apt update

install () {
    if ! which "$1" ; then
        $2 $1 $3
    else
        echo $1 already installed
    fi
}

# Apt
install "make" "apt install"
install "curl" "apt install"
install "wget" "apt install"
install "screen" "apt install"

# # Snaps
install "codium " "snap install" "--classic"
install "code" "snap install" "--classic"
install "gimp" "snap install" "--classic"

# Google Chrome
./utils/install_chrome.sh

# # VSCode plugins
code --install-extension ritwickdey.LiveServer
# # Codium plugins
codium --install-extension ritwickdey.LiveServer

# Node.js - managed by n
if [ ! -d "/home/interactionstation/.n" ] || [ ! -d "/home/hadmin/.n" ] ; then
    sudo /bin/bash ./utils/run_as_user.sh 'curl -L https://git.io/n-install | N_PREFIX=$HOME/.n bash -s -- -y lts 14.18.3'
fi

# # Arduino
if ! which "arduino" ; then
    wget -O arduino.tar.xz https://downloads.arduino.cc/arduino-nightly-linux64.tar.xz
    mkdir arduino && tar xf arduino.tar.xz -C arduino --strip-components 1
    cd arduino && ./install.sh && cd .. && rm -rf arduino.tar.xz
fi

# Arduino CLI
if ! which "arduino-cli" ; then
    curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=. sh && mv ./arduino-cli /usr/local/bin
fi
