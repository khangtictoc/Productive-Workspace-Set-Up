#! /bin/bash

if ! command -v ngrok 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] ngrok"
    curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
        | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
        && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
        | sudo tee /etc/apt/sources.list.d/ngrok.list \
        && sudo apt update \
        && sudo apt install ngrok
else
    echo "- [CHECKED ✅] ngrok command exists"
fi