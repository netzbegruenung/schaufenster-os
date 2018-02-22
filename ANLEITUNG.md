# Detailierte Anleitung

## Für Eilige

1. Clone dieses Repository
2. Bearbeite die Einstellungen in `config.env`
3. Führe (unter Linux oder Mac OS) das Script `build-image.sh` aus
4. Finde die fertige Image-Datei im Ordner `volume`
5. Schreibe das Image auf eine frisch formatierte SD-Karte

## Voraussetzungen

- Linux oder Mac OS
- [Docker](https://www.docker.com/community-edition)
- Internetverbindung – es werden ca. 2.5 GB Daten herunter geladen.
- Zugangsdaten für das WLAN, in dem der Client seine Dienste verrichten
  soll.
  - Name des Netzwerks (SSID)
  - Passwort
- URL der Seite, die der Client automatisch nach dem Start anzeigen soll
- Micro-SD-Karte mit mind. 4 GB Speicher
- Schnittstelle für SD-Karten
- [Etcher](https://etcher.io/) oder eine andere Software zum Schreiben eines ISO-Image auf SD-Karte

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

## Schritt 2: Konfigurieren

In deinem lokalen Verzeichnis `schaufenster-os` (das dieses soeben geclonte
Repository enthält, befindet sich die Datei

    config.env

Diese Datei öffnest du in einem Texteditor, um einige Einstellungen anzupassen.
Du kannst dich dabei von den Kommentaren leiten lassen.

Schließlich speicherst du die geänderte Datei.

## Schritt 3: Build starten

Nun ist es Zeit, die Erzeugung des Image zu starten. Dazu benötigst du eine
Kommandozeile.

Wechsele zunächst in der Kommandozeile in dein lokales `schaufenster-os` Verzeichnis.

Führe nun diesen Befehl aus:

    ./build-image.sh

Falls die Kommandozeile Neuland für dich ist: du musst das Kommando genau so
wie es hier steht an der Eingabeaufforderunge eingeben und mit Enter bzw. Return
bestätigen.

Jetzt hast du je nach Internetanbindung und Rechenleistung einige Zeit, dir
einen Kaffee oder Tee zu machen.

Wenn alles nach Plan läuft, bekommst Du am Ende eine Ausgabe, die dir sagt,
wohin deine neue Image-Datei geschrieben wurde.

**Tipp**: Lass dich nicht vom Dateinamen des Image irritieren. Der Name enthält ein
Datum, dass schon einige Zeit zurück liegen kann. Das liegt daran, dass der
Name des zugrunde liegenden Rasbpian Image beibehalten wird.

## Schritt 4: Formatiere die SD-Karte

Formatiere die SD-Karte mit dem MS-DOS (FAT) Dateisystem.

Unter Mac OS steht dafür das Programm "Festplattendienstprogramm" (Disk Utility)
zur Verfügung. In der englischen Version findet man die Formatierungsfunktion unter
"Edit" / "Erase...".

Am Mac Terminal geht das so. Mit diesem Kommando finden wir heraus, welches
Gerät unsere SD-Karte ist:

    diskutil list

Angenommen, unsere Karte ist `/dev/disk4`:

    sudo diskutil eraseDisk FAT32 SCHAUFENST MBRFormat /dev/disk4

Eine ausführliche Anleitung für das Formatieren von SD-Karten und mehr gibt
es [hier](https://www.raspberrypi.org/documentation/installation/installing-images/mac.md).

Falls Du eine SD-Karte größer 32 GB verwenden möchtest, beachte bitte ein paar
Hinweise von [dieser Seite](https://www.raspberrypi.org/documentation/installation/sdxc_formatting.md).

## Schritt 5. Image auf SD-Karte speichern

Starte [Etcher](https://etcher.io/).

Öffne die Image-Datei im Verzeichnis `schaufenster-os/build`.

Steck die SD-Karte (falls nötig mit Adapter) in den dafür vorgesehenen Schlitz an deinem Computer bzw. Kartenleser.

Stelle sicher, dass in Etcher die Karte als Medium ausgewählt ist.

Klicke auf "Flash!". Etcher beschreibt die Karte und überprüft dann die geschriebenen Daten.

## Schritt 6: Pi hochfahren

Entferne ggf. das Netzkabel von deinem Pi.

Stecke die geflashte SD-Karte in deinen Pi.

Schließe Monitor und Netzteil an den Pi an.

Wenn alles läuft, wie es soll, bekommst du nach einer Weile die konfigurierte Webseite angezeigt.
