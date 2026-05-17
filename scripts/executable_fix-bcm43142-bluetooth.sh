#!/usr/bin/env bash

set -e

echo "===> Installing required packages"

sudo apt update

sudo apt install -y \
    git \
    bluez \
    blueman

TMP_DIR="/tmp/broadcom-bt-firmware"

echo "===> Cloning firmware repo"

rm -rf "$TMP_DIR"

git clone https://github.com/winterheart/broadcom-bt-firmware.git "$TMP_DIR"

cd "$TMP_DIR"

FIRMWARE_FILE="brcm/BCM43142A0-0a5c-216d.hcd"

if [ ! -f "$FIRMWARE_FILE" ]; then
    echo "Firmware file not found!"
    exit 1
fi

echo "===> Installing firmware"

sudo mkdir -p /lib/firmware/brcm

sudo cp "$FIRMWARE_FILE" /lib/firmware/brcm/

echo "===> Reloading Bluetooth kernel modules"

sudo modprobe -r btusb btbcm || true

sudo modprobe btusb
sudo modprobe btbcm

echo "===> Restarting Bluetooth service"

sudo systemctl restart bluetooth

echo "===> Done"

echo
echo "Run:"
echo "    bluetoothctl list"
echo
echo "If controller appears, Bluetooth is fixed."
