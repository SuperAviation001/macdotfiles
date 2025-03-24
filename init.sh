#!/bin/bash

set -eu

USER=$(id -un)

if [ ! command -v brew >/dev/null 2>&1 ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew ✅"
fi

if ! brew list yadm >/dev/null; then
    brew install yadm
    echo "yadm ✅"
fi

if [ ! -f "$HOME/.config/yadm/bootstrap" ]; then
    yadm clone https://github.com/ZhongXiLu/macdotfiles.git --no-bootstrap
fi

yadm bootstrap

if [ $USER == "zhongxilu" ]; then
    yadm decrypt --yadm-archive "$HOME/.config/yadm/archive"
fi

if git config remote.faraway.url > /dev/null; then
    yadm remote add origin git@github.com:ZhongXiLu/dotfiles.git
fi
