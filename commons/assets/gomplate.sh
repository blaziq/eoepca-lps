#!/bin/bash

if [[ -e /tmp/assets/gomplate.7z ]]; then
  # Gomplate is a dependency of the deployment tool
  # Installing it from local instead then remote for speed
  # curl -s -S -L -o /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v4.3.0/gomplate_linux-amd64 && chmod +x /usr/local/bin/gomplate
  echo "Installing gomplate..." >> ${LOG}
  mkdir -p /usr/local/bin/ 
  7z x /tmp/assets/gomplate.7z -o/usr/local/bin/
  chmod +x /usr/local/bin/gomplate
fi
