# schaufenster-os

Betriebssystem für Raspberry Pi zum Betrieb eines Info-Displays, speziell für den Einsatz in BÜNDNIS 90/DIE GRÜNEN Büros

## Einführung

Unter dem Projektnamen [schaufenster](https://github.com/netzbegruenung/schaufenster) stellen
wir Werkzeuge zusammen, die Gliederungen von BÜNDNIS 90/DIE GRÜNEN dabei helfen soll,
Informationen auf Monitoren anzuzeigen. Zum Beispiel in den Schaufenstern der Büros von
Orts- und Kreisverbänden.

Hier, in diesem Repository, findest du die Hilfsmittel, um dir einen
[Raspberry Pi](https://www.raspberrypi.org/) Computer (kurz: Pi) zum Betrieb
eines Info-Monitors aufzusetzen. Wir nennen das im Rahmen des Projekts den "Client".

Vorteile dieder Lösung:

- **Günstig und verfügbar**: Man bekommt den Pi komplett mit Netzteil, Gehäuse
  etc. neu für ca. 60 EUR über den Versandhandel.
- **Energiesparend**: Verglichen mit dem Energiebedarf eines Monitors fällt der
  des Pi kaum ins Gewicht.
- **Open Source Software**: Diese Lösung setzt komplett auf quelloffene und
  kostenlose Software.
- **Große Community**: Es gibt eine unerschöpfliche Menge an Artikeln, Software
  und nicht zuletzt Menschen, die dabei helfen, den Pi für bestimmte Einsatzzwecke
  zu konfigurieren. Die meisten verwendeten Softwaremodule bewähren sich tagtäglich
  in zahllosen Anwendungen.

Die hier erhältliche Software ist bislang ausschließlich mit dem aktuellsten
[Pi Model 3B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
getestet.

Mit den Werkzeugen in diesem Repository kannst du ein angepasstes
**Betriebssystem-Image** für den Pi erzeugen. (Ein Image ist eine einzige Datei,
die den gesamten Inhalt eines oder mehrerer Laufwerke enthält.)

Dabei setzen wir auf [FullPageOS](https://github.com/guysoft/FullPageOS/), was
eine für Info-Bildschirme optimierte Variante von
[Raspbian](https://www.raspbian.org/) ist. Das wiederum ist eine
eine für Pi optimierte Variante von [Debian Linux](https://www.debian.org/).

Dieses Image wird auf einer SD-Karte gespeichert und der Pi dann mit dieser Karte
gebootet. Sobald er gebootet ist, zeigt Monitor, der an den Pi angeschlossen ist,
im Vollbild-Modus eine Webseite deiner Wahl an.

## Anleitung

### Übersicht

So kannst du dir mit den hier angebotenen Werkzeugen dein Image erstellen
und deinen Pi konfigurieren:

- Inhalt dieses Repositories herunter laden
- Konfigurationsdatei anpassen, insbesondere WLAN-Einstellungen und
  Webseiten-URL zur Anzeige
- Script `TODO` ausführen
- Image auf SD-Karte schreiben
- SD-Karte in Pi stecken

### Detailierte Anleitung

Siehe Datei `ANLEITUNG.md`

## So kannst Du helfen

- Testen (gerne auf verschiedenen Pi-Modellen) und Korrekturen zur Anleitung
  beisteuern
- Scripte und Anleitung für Windows ergänzen/anpassen
- Fehler beheben, Code verbessern

## Kontakt und Unterstützung

Es bieten sich zwei Wege an:

- Kanal [#netzbegruenung-cfgrn](https://chatbegruenung.de/channel/netzbegruenung-cfgrn) auf chatbegruenung.de
- [Issues](https://github.com/netzbegruenung/schaufenster-os/issues) hier in diesem Repository (falls es konkret um schaufenster-os geht)
- Issues in [schaufenster](https://github.com/netzbegruenung/schaufenster/issues), wenn es um allgemeinere Fragen zum Projekt geht

## Bekannte Probleme

- Netzwerkeinstellungen in config.env werden noch nicht ins Image übernommen.

- Einträge in der Datei `fullpageos-network.txt` werden nicht berücksichtigt. Bitte `fullpageos-wpa-supplicant.txt` verwenden.

- Auf deutschsprachigen Seiten erscheint in Chromium das Translate Tool. Siehe
  [guysoft/FullPageOS#7](https://github.com/guysoft/FullPageOS/issues/7). Um dies
  zu beheben, muss die Locale-Einstellung des Systems geändert werden. Wie das
  geht, erfährst Du in der detailierten Anleitung.

- Das Passwort für VNC-Zugang muss manuell via SSH eingerichtet werden.

- `FULLPAGEOS_OVERRIDE_LOCALE` scheint bedeutungslos. Deutsche Locale wird nicht
  mitinstalliert. Paket `locales-all` muss nachinstalliert werden,

- Sobald eine neu beschriebene SD-Karte einmal im Pi verwendet wurde, muss sie neu formatiert
  werden, bevor sie erneut beschrieben werden kann. Sonst kommt es beim Booten zum
  Fehler `Kernel panic - not syncing:
  Requested init /usr/lib/raspi-config/init_resize.sh failed (error -8)`.

## Dank und Anerkennung

- [guysoft](https://github.com/guysoft) für [CustomPiOS](https://github.com/guysoft/CustomPiOS/) und [FullPageOS](https://github.com/guysoft/FullPageOS/)
