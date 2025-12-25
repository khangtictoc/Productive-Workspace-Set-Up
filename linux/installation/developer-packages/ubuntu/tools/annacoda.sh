#! /bin/bash

if ! command -v conda 2>&1 >/dev/null
then
    wget --progress=dot:giga https://repo.anaconda.com/archive/Anaconda3-2025.06-0-Linux-x86_64.sh
    bash Anaconda3-2025.06-0-Linux-x86_64.sh

    echo "[INFO] >>>> Clean Up"
    rm Anaconda3-2025.06-0-Linux-x86_64.sh

    echo "[CHECKED ✅] Annaconda installed! Try 'conda -h'"
else
    echo "[CHECKED ✅] Annaconda has been already installed! Try 'conda -h'"
fi