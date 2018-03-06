#!/bin/bash

modprobe loop

cd /FullPageOS/src

# Apply the default URL
if [ ! -z "$SCHAUFENSTER_URL" ]
then
  echo $SCHAUFENSTER_URL > /FullPageOS/src/modules/fullpageos/filesystem/boot/fullpageos.txt
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
