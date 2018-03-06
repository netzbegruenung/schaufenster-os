# Detailierte Anleitung

## Für Eilige

1. Clone dieses Repository und lade ein aktuelles Raspbian Lite Image herunter
2. Bearbeite die Einstellungen in `config.env`
3. Führe (unter Linux oder Mac OS) das Script `build.sh` aus
4. Bearbeite ein paar Dateien in der `boot` Partition des neuen Image
5. Formatiere eine SD-Karte
6. Schreibe das Image auf die frisch formatierte SD-Karte
7. Verwende die frisch geflashte Karte mit Deinem Pi
8. Passe weitere Einstellungen an

## Voraussetzungen

- Linux oder Mac OS
- [Docker](https://www.docker.com/community-edition)
- Internetverbindung – es werden ca. 2,5 GB Daten herunter geladen.
- Zugangsdaten für das WLAN, in dem der Client seine Dienste verrichten
  soll.
  - Name des Netzwerks (SSID)
  - Passwort
- URL der Seite, die der Client automatisch nach dem Start anzeigen soll
- Micro-SD-Karte mit mind. 4 GB Speicher
- Schnittstelle für SD-Karten bzw. Kartenleser
- [Etcher](https://etcher.io/) oder eine andere Software zum Schreiben eines ISO-Image auf SD-Karte
- Entweder Zugang zum (WLAN-)-Router oder eine
  Tastatur am Pi zum direkten Login

## Schritt 1: Herunterladen

Zunächst musst du, falls noch nicht geschehen, dieses
Repository auf deinen Computer herunter laden oder (im
git-Jargon) "clonen".

- Entweder mit dem `git` Kommantozeilentool:

```nohighlight
git clone https://github.com/netzbegruenung/schaufenster-os.git
cd schaufenster-os/
```

- oder alternativ durch [Clonen mit GitHub Desktop](x-github-client://openRepo/https://github.com/netzbegruenung/schaufenster-os)

- oder durch [Download als ZIP-Datei](https://github.com/netzbegruenung/schaufenster-os/archive/master.zip).

Darüber hinaus benötigst Du ein Original Raspian Lite Image. Dieses kannst Du Dir
über die Kommandozeile so in den `image/` Ordner herunter laden:

```nohighlight
cd image/
curl -O -L https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-12-01/2017-11-29-raspbian-stretch-lite.zip
cd ..
```

Wenn Du hierfür nicht die Kommandozeile nutzen möchtest, kannst Du Dich alternativ auf
[downloads.raspberrypi.org](https://downloads.raspberrypi.org/raspbian_lite/images/)
zum aktuellsten Image durchklicken und da die entsprechende ZIP-Datei in
Deinem Browser herunter laden.

## Schritt 2: Konfigurieren

In deinem lokalen Verzeichnis `schaufenster-os` (das dieses soeben geklonte
Repository enthält, befindet sich die Datei `config.env`.

Diese Datei öffnest du in einem Texteditor, um einige Einstellungen anzupassen.
Du kannst dich dabei von den Kommentaren leiten lassen.

Schließlich speicherst du die geänderte Datei.

## Schritt 3: Build starten

Nun ist es Zeit, die Erzeugung des Image zu starten. Dazu benötigst du eine
Kommandozeile.

Wechsele zunächst in der Kommandozeile in dein lokales `schaufenster-os` Verzeichnis.

Führe nun diesen Befehl aus:

    ./build-image.sh

Jetzt hast du je nach Internetanbindung und Rechenleistung einige Zeit, dir
einen Kaffee oder Tee zu machen.

Wenn alles nach Plan läuft, bekommst Du am Ende eine Ausgabe, die dir sagt,
dass Deine neue Image-Datei nun im Ordner `build/` bereit liegt.

**Tipp**: Lass dich nicht vom Dateinamen des Image irritieren. Der ist nahezu
identisch mit dem des Image, das Du in Schritt 1 herunter geladen hast. Die
Dateien sind es jedoch nicht.

## Schritt 4: Image mounten und Dateien bearbeiten

Nun müssen wir das frisch erzeugte Image "mounten", um ein paar Änderungen
vorzunehmen.

Unter Mac OS geht das, indem Du im Finder zu Deinem `schaufenster-os/build`
Ordner navigierst. Dann reicht im Normalfall ein Doppelklick auf die Image-Datei.
Dies öffnet die Datei mit dem "DiskImageMounter", was bedeutet, dass der Inhalt
des Image wie ein Wechseldatenträger zur Verfügung steht.

Im Finder sollte ein neues Laufwerk `boot` erscheinen. Öffne dieses.

Öffne als nächstes die Datei `fullpageos-wpa-supplicant.txt` in einem
Texteditor. Hier gilt es, die WLAN-Einstellungen so anzupassen, dass Dein Pi
das entsprechende Netz findet und die Zugangsdaten kennt. Die Datei bietet
Beispiele für WPA/WPA2-gesicherte Netze, WEP-gesicherte und gänzlich
unverschlüsselte. Entferne an der entsprechenden Stelle die Kommentarzeichen
(`#`), um die Einträge wirksam zu machen.

Hier eine komplette Beispiel-Konfiguration für ein WPA/WPA2 Netzwerk:

```nohighlight
network={
  ssid="netzwerk-name"
  psk="geheimes-wlan-passwort"
}

country=DE
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
```

Beachte bitte auch die Ländereinstellung `country=DE`.

Speichere die geänderte Datei. "Unmounte" dann das Image. Hierzu findest Du im
Finder einen entsprechenden Button am Laufwerk-Eintrag.

## Schritt 5: Formatiere die SD-Karte

Formatiere die SD-Karte mit dem MS-DOS (FAT) Dateisystem.

Am Mac Terminal geht das so. Stecke zunächst die SD-Karte in den Kartenleser.
Finde dann mit diesem Kommando heraus, welches Gerät der SD-Karte entspricht:

    diskutil list

Angenommen, unsere Karte ist `/dev/disk2`, dann startest Du die Formatierung mit
dem Befehl

    sudo diskutil eraseDisk FAT32 SCHAUFENST MBRFormat /dev/disk2

Eine ausführliche Anleitung für das Formatieren von SD-Karten und mehr gibt
es [hier](https://www.raspberrypi.org/documentation/installation/installing-images/mac.md).

Falls Du eine SD-Karte größer 32 GB verwenden möchtest, beachte bitte ein paar
Hinweise von [dieser Seite](https://www.raspberrypi.org/documentation/installation/sdxc_formatting.md).

## Schritt 6. Image auf SD-Karte speichern

Starte [Etcher](https://etcher.io/).

Öffne die Image-Datei aus dem Verzeichnis `schaufenster-os/build`.

Stecke die SD-Karte (falls nötig mit Adapter) in den dafür vorgesehenen Schlitz
an Deinem Computer bzw. Kartenleser.

Stelle sicher, dass in Etcher die Karte als Medium ausgewählt ist.

Klicke auf "Flash!". Etcher beschreibt die Karte und überprüft dann die geschriebenen Daten.

## Schritt 7: Pi hochfahren

Entferne ggf. das Netzkabel von deinem Pi.

Stecke die geflashte SD-Karte in deinen Pi.

Schließe Monitor und Netzteil an den Pi an.

Wenn alles läuft, wie es soll, bekommst du nach einer Weile die konfigurierte Webseite angezeigt.

## Schritt 8: Weitere Einstellungen anpassen

Nun nehmen wir noch ein paar Einstellungen am laufenden System vor. Dafür
müssen wir herausfinden, welche IP-Adresse der Pi im Netzwerk bekommen hat.
Dies kannst Du normalerweise über den Router herausfinden. Diese IP-Adresse
kannst Du dann für einen Login mittels SSH benutzen:

    ssh pi@<ip-adresse>

Alternativ kannst Du Dich direkt mit Tastatur und Maus anmelden. In beiden
Fällen wird das gleiche Passwort benötigt. Hast Du es in `config.env` bei
der Einstellung `default` belassen, lautet das Passwort `raspberry`. Andernfalls
kennst nur Du das Passwort.

Als nächstes gilt es, die richtige Sprache für den Browser einzustellen. Rufe dazu den Befehl

    sudo raspi-config

auf. Im Menü wählst Du die "Localisation Options"
und dann "Change Locale". Aus der Liste der
verfügbaren Ländereinstellungen wählst Du
`de_DE.UTF-8 UTF-8` aus.

Als nächstes installieren wir `unclutter`, um den
Mauszeiger automatisch auszublenden.

    sudo apt-get install -y unclutter

Ändere dann die `xinitrc` wie folgt:

    sudo vim /etc/X11/xinit/xinitrc

Navigiere mit den Pfeiltasten ans Ende der Datei.
Drücke die Taste `i` und füge mit Hilfe der `Enter`-Taste eine neue Zeile ein. Gib nun die Zeile

    unclutter -idle 3 -root

ein. Drücke dann die `ESC`-Taste und gib dann `:wq` ein, um die Änderungen zu speichern und den
Editor zu beenden.

Starte nun den Raspberry so neu:

    sudo reboot
