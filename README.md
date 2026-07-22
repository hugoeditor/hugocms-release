# HugoCMS

Webbasierter Dateimanager und Editor zum Pflegen von [Hugo](https://gohugo.io)-Webseiten —
ohne Kommandozeile, direkt im Browser. Eine Installation verwaltet **mehrere
Webseiten**; Inhalte und Vorlagen werden über die Oberfläche bearbeitet, und ein
Knopf veröffentlicht die fertige Seite mit Hugo.

Dieses Repository ist das **fertig gebaute Auslieferungspaket**. Es wird auf den
Server geladen und dort eingerichtet — ein Build (Node.js, npm) ist nicht nötig.

> **Hinweis: Rolling Release.** HugoCMS erscheint fortlaufend, ohne feste
> Versionssprünge. Hier liegt jeweils die getestete und freigegebene Fassung —
> fertig gebaut und direkt einsatzfähig. Der Quellcode und alles, was zum
> Entwickeln der App und des Backends gebraucht wird, liegt im Repo
> [hugocms](https://github.com/hugoeditor/hugocms).

**Funktionen im Überblick**

- Dateimanager: durchsuchen, anlegen, umbenennen, kopieren, verschieben,
  löschen (Papierkorb), Mehrfachauswahl, Kontextmenü
- Hochladen (auch per Ziehen-und-Ablegen), Herunterladen, Bildvorschauen und
  Bildbetrachter
- Text- und visueller Markdown-Editor mit Schutz des Front Matter
- Veröffentlichen-Knopf: ruft Hugo für die aufgerufene Webseite auf
- Rekursive Namenssuche
- Optionaler **KI-Assistent** (Claude), der direkt auf den Dateien der Webseite
  arbeitet
- Optionale **Pro-Version** mit Git-Versionierung (Status, Verlauf, Commit, Push)
- Anmeldedaten und Einstellungen lassen sich im laufenden Betrieb über die
  Oberfläche ändern

## Systemvoraussetzungen

- **PHP 8.1 oder neuer** als Webserver-Modul oder über PHP-FPM
  - Erweiterung `fileinfo` (üblicherweise vorhanden)
  - Erweiterung `gd` empfohlen — für verkleinerte Bildvorschauen; ohne `gd`
    wird das Originalbild ausgeliefert
- **Apache oder Nginx** (oder ein anderer Webserver, der PHP ausführt).
  Symlinks sind **nicht** erforderlich — die Einrichtung kommt ohne aus und
  läuft daher auch auf einfachem Shared Hosting (z. B. Hetzner Webhosting).
- **SSH-Zugang** zum Server, um die Einrichtungs-Skripte auszuführen
- **Hugo** wird nicht vorausgesetzt: Das Einrichtungs-Skript lädt bei Bedarf die
  passende Hugo-Version (Variante *extended*) selbst herunter.
- Optional für die **Pro-Version**: `git` auf dem Server und ein Hugo-Projekt,
  das ein Git-Repository ist.
- Optional für den **KI-Assistenten**: ein Anthropic-API-Schlüssel.

Auf dem Server, der die Einrichtung ausführt, werden außerdem die üblichen
Kommandozeilenwerkzeuge erwartet (`bash`, `git`, `curl` bzw. `wget`,
`sha256sum`, `tar`).

## Installation

### 1. Paket auf den Server holen

Das Repository an einen Ort **außerhalb des Webroots** klonen — der PHP-Code
soll nicht direkt über das Web erreichbar sein:

```bash
git clone <DIESE-REPO-URL> /pfad/zu/hugocms-release
cd /pfad/zu/hugocms-release
```

Das Repository darf an beliebiger Stelle liegen; die Skripte finden ihre eigene
Wurzel selbst.

### 2. Eine Webseite einrichten

Für jede Hugo-Webseite das Einrichtungs-Skript mit Hostname und
Veröffentlichungsverzeichnis aufrufen:

```bash
bin/install.sh <host> <hugo-publish-ordner>
#   z. B.
bin/install.sh kunde-a.example.com /var/www/kunde-a/public
```

- `<host>` ist der reine Hostname der Webseite, so wie der Browser ihn sendet —
  ohne `https://`, ohne Port, ohne Pfad.
- `<hugo-publish-ordner>` ist das Verzeichnis, in das Hugo die fertige Webseite
  schreibt. Dessen **Elternverzeichnis** gilt als Hugo-Projektverzeichnis;
  dort werden `content/`, `layouts/` und `static/` erwartet bzw. angelegt.

Das Skript erledigt in einem Durchgang:

1. **Hugo bereitstellen** — fehlt das Programm noch, wird es heruntergeladen und
   die Prüfsumme verglichen.
2. **Zugänge anlegen** — eine Konfiguration für diese Webseite mit Zugriff auf
   das gesamte Projektverzeichnis sowie die bequemen Direktzugänge *Inhalt*
   (`content/`), *Vorlagen* (`layouts/`) und *Medien* (`static/`).
3. **Oberfläche ausliefern** — die Editor-Oberfläche unter `/edit/` und den
   API-Endpunkt unter `/cms-api/` (ohne Symlinks; der PHP-Code bleibt im
   Release-Repo).

Anschließend ist die Webseite unter **`https://<host>/edit/`** erreichbar.

### 3. Ersteinrichtung im Browser

Beim ersten Aufruf von `https://<host>/edit/` blendet HugoCMS ein
**Einrichtungs-Formular** ein (es gibt noch keine Konfiguration und kein
Konto). Dort werden Anmeldename und Passwort festgelegt; danach ist man direkt
angemeldet. Ein Passwort-Hash muss nicht von Hand erzeugt werden — das übernimmt
das Formular.

Der **Anmeldename und das Passwort gelten für die gesamte Installation** (alle
Webseiten teilen sich das Backend und damit die Anmeldung). Voneinander
unabhängig sind nur die Zugänge je Webseite.

### Weitere Webseiten hinzufügen

Für jede zusätzliche Webseite `bin/install.sh` erneut mit deren Hostnamen und
Publish-Ordner aufrufen. Die Anmeldung gilt installationsweit; lediglich die
Zugänge der jeweiligen Webseite kommen hinzu.

### Aktualisieren

Nach einer neuen Version genügt im Release-Repo:

```bash
bin/update.sh
```

Das Skript holt den neuen Stand (`git pull`) und liefert die Oberfläche für
**alle** eingerichteten Webseiten frisch aus. Das Backend ist nach dem `git
pull` bereits aktuell; `update.sh` erneuert nur die kopierten Oberflächen.

- `bin/update.sh --no-pull` — nur ausliefern, ohne `git pull`
- `bin/update.sh --dry-run` — nur anzeigen, was geschähe

## Bedienung

### Anmelden

Webseite unter `https://<host>/edit/` öffnen und mit den bei der Einrichtung
festgelegten Daten anmelden. Eine Anmeldung bleibt standardmäßig 8 Stunden bei
Inaktivität gültig; jede Aktion frischt das Fenster auf.

### Dateien verwalten

Die linke Spalte zeigt die **Zugänge** (Inhalt, Vorlagen, Medien, Projekt) der
Webseite. Im Hauptbereich lassen sich Verzeichnisse öffnen, Dateien und Ordner
anlegen, umbenennen, kopieren, verschieben und löschen. Gelöschtes landet im
**Papierkorb** und kann wiederhergestellt oder endgültig entfernt werden.
Dateien lassen sich per Ziehen-und-Ablegen hochladen und einzeln herunterladen;
Bilder werden als Vorschau und im Betrachter angezeigt.

### Bearbeiten

Textdateien öffnen sich im Editor. Markdown-Dateien können wahlweise visuell
bearbeitet werden, wobei das **Front Matter** (der Kopfbereich mit den
Metadaten) geschützt bleibt. Beim Speichern schützt HugoCMS vor dem versehent-
lichen Überschreiben einer zwischenzeitlich geänderten Datei.

### Veröffentlichen

Ein **Veröffentlichen-Knopf** in der Titelleiste ruft Hugo für die aufgerufene
Webseite auf und erzeugt die fertige Seite. Eine offene, ungespeicherte Datei
wird vorher automatisch gesichert. Die Ausgabe von Hugo (Statistik bzw.
Fehlermeldungen) erscheint anschließend in einem Dialog. Der Knopf erscheint
nur, wenn Hugo eingerichtet ist (das Einrichtungs-Skript erledigt das).

### KI-Assistent (optional)

Ist ein Anthropic-API-Schlüssel hinterlegt, erscheint ein **Roboter-Knopf**, der
einen Chat öffnet. Der Assistent kennt Hugo und arbeitet direkt auf den Dateien
der aufgerufenen Webseite — im Rahmen derselben Grenzen wie die Oberfläche. Er
kennt drei Schreibmodi:

| Modus      | Verhalten                                                   |
|------------|-------------------------------------------------------------|
| `readonly` | nur lesen                                                   |
| `confirm`  | zeigt jede Schreibaktion vor der Ausführung an (Standard)   |
| `auto`     | führt Schreibaktionen direkt aus                            |

Den Schlüssel, das Modell und den Schreibmodus trägt man bei der Einrichtung im
Browser ein oder später über das Zahnrad in der Titelleiste. Jede Webseite kann
zusätzlich eine versteckte Datei `.hugocms-assistant.md` im Wurzelverzeichnis
eines Zugangs hinterlegen, deren Inhalt der Assistent als vorrangige Anweisung
übernimmt (z. B. „Front Matter immer als YAML", „Inhalte auf Deutsch").

### Pro-Version: Git-Versionierung (optional)

Mit einem gültigen **Lizenzschlüssel** schaltet HugoCMS pro Webseite die
Git-Versionierung frei: Status, Commit-Verlauf, Diff, Commit, Push und das
Zurücksetzen des Arbeitsbaums — alles über einen **Repository-Knopf** in der
Titelleiste. Voraussetzung ist, dass das Hugo-Projektverzeichnis ein
Git-Repository ist und für `push` die Zugangsdaten der Gegenstelle auf dem Server
eingerichtet sind.

Den Schlüssel über den **Lizenz-Knopf** in der Titelleiste einfügen und
aktivieren. Die Lizenz gilt pro Webseite, ist an deren Domain gebunden und hat
kein Ablaufdatum.

### Einstellungen im laufenden Betrieb ändern

- **Zahnrad** in der Titelleiste: Sitzungs- und Log-Einstellungen, Hugo-Programm
  sowie der KI-Assistent (Schlüssel, Modell, Schreibmodus). Ein leeres
  Schlüsselfeld lässt einen vorhandenen Schlüssel unverändert.
- **Klick auf den Benutzernamen**: Anmeldename und Passwort ändern (zur
  Bestätigung ist das aktuelle Passwort nötig; danach folgt eine Neuanmeldung).

## Fehlersuche

- **Die Anmeldung schlägt fehl oder es erscheint ein Hinweis zum
  Sitzungsverzeichnis.** Das Verzeichnis `backend/var/sessions` muss für den
  Webserver-Benutzer beschreibbar sein. HugoCMS meldet ein nicht beschreibbares
  Verzeichnis vor dem Login im Klartext.
- **HTTP 500.** Häufigste Ursache ist ein Zugangs-Pfad, der auf dem Server nicht
  existiert oder nicht lesbar ist. Zur genaueren Diagnose die Log-Stufe (Zahnrad
  → Log) vorübergehend auf `debug` setzen, die Aktion wiederholen und
  `backend/log/hugocms.log` ansehen. Bleibt das Log leer, liegt der Fehler vor
  dem PHP-Code (z. B. fehlende PHP-Erweiterung) — dann ins Server-Log schauen.
- **Der Veröffentlichen-Knopf fehlt.** Hugo ist nicht eingerichtet. Das
  Einrichtungs-Skript erneut ausführen bzw. den Hugo-Programmpfad im Zahnrad
  prüfen.
- **Nach einer Aktualisierung erscheint die alte Oberfläche.** `bin/update.sh`
  ausführen, damit die kopierte Oberfläche aller Webseiten erneuert wird, und im
  Browser den Zwischenspeicher leeren.

## Sicherheitshinweise

- Das Release-Repo **außerhalb des Webroots** belassen; nur `edit/` und
  `cms-api/` werden in den öffentlichen Bereich ausgeliefert.
- Jeder Zugang sperrt den Zugriff auf sein Verzeichnis ein; ein Ausbruch über
  `..` ist nicht möglich.
- Alle Datei-Operationen erfordern eine Anmeldung; Schreibaktionen sind zusätz-
  lich gegen webseitenübergreifende Anfragen (CSRF) geschützt.
- Geheimnisse (Passwort-Hash, API-Schlüssel) verlassen das Backend nie und
  werden in Formularen nie angezeigt; ein leeres Feld bedeutet „unverändert".
- Enthält die Konfiguration einen API-Schlüssel, die Datei mit restriktiven
  Rechten (`0640`) schützen.
