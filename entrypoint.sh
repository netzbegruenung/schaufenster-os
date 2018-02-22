#!/bin/bash

modprobe loop

cd /FullPageOS/src

# Apply the default URL
if [ ! -z "$SCHAUFENSTER_URL" ]
then
  echo $SCHAUFENSTER_URL > /FullPageOS/src/modules/fullpageos/filesystem/boot/fullpageos.txt
fi

INTERFACE_FILE=/FullPageOS/src/modules/fullpageos/filesystem/boot/fullpageos-network.txt
SUPPLICANT_FILE=/FullPageOS/src/modules/fullpageos/filesystem/boot/fullpageos-wpa-supplicant.txt

# Apply network config
if [ ! -z "$SCHAUFENSTER_WIFI_WPA_SSID" ]
then
  # interface file
  echo "auto wlan0" >> $INTERFACE_FILE
  echo "iface wlan0 inet dhcp" >> $INTERFACE_FILE
  echo "   wireless-essid \"$SCHAUFENSTER_WIFI_WPA_SSID\"" >> $INTERFACE_FILE
  echo "   wireless-key \"$SCHAUFENSTER_WIFI_WPA_KEY\"" >> $INTERFACE_FILE
  # supplicant file
  echo "country=DE" >> $SUPPLICANT_FILE
  echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" >> $SUPPLICANT_FILE
  echo "update_config=1" >> $SUPPLICANT_FILE
  echo "network={" >> $SUPPLICANT_FILE
  echo "  ssid=\"$SCHAUFENSTER_WIFI_WPA_SSID\"" >> $SUPPLICANT_FILE
  echo "  psk=\"$SCHAUFENSTER_WIFI_WPA_KEY\"" >> $SUPPLICANT_FILE
  echo "}" >> $SUPPLICANT_FILE
fi

if [ ! -z "$SCHAUFENSTER_WIFI_WEP_SSID" ]
then
  if [ -z "$SCHAUFENSTER_WIFI_WPA_SSID" ]
  then
    echo "country=DE"
    echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev"
    echo "update_config=1"
  fi
  echo "network={" >> $SUPPLICANT_FILE
  echo "  ssid=\"$SCHAUFENSTER_WIFI_WEP_SSID\"" >> $SUPPLICANT_FILE
  echo "  psk=\"$SCHAUFENSTER_WIFI_WEP_KEY\"" >> $SUPPLICANT_FILE
  echo "}" >> $SUPPLICANT_FILE
fi

# Execute FullPageOS build
bash -x ./build_dist

# Move our new image to the volume outside the container
mv /FullPageOS/src/workspace/*.img /build/

# Print some success info
echo ""
echo ""
echo "========================================================================="
echo ""
echo "Fertig. Hier ist das Ergebnis:"
echo ""
ls -l /build/*.img
echo ""
