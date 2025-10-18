#! /bin/bash

if ! command -v sysz 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] sysz"
    wget --progress=dot:giga -O /usr/local/bin/sysz https://github.com/joehillen/sysz/releases/latest/download/sysz
    sudo chmod +x /usr/local/bin/sysz
else
    echo "- [CHECKED ✅] sysz command exists"
fi