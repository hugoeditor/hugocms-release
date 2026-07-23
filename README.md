# HugoCMS

### Das erste CMS, dem du einfach sagst, was zu tun ist.

> ### 🗣️ „Ändere die Öffnungszeiten auf 9:00 bis 23:00 Uhr."

Du sagst es in normalen Sätzen — HugoCMS erledigt es: findet die richtige Stelle,
ändert sie, fertig. Kein Suchen im Menü, kein Ausfüllen von Feldern, kein
Handbuch. Und veröffentlicht wird mit einem Knopf: eine Seite, die niemand hacken
kann und die in Millisekunden lädt.

Kein Datenbank-Server. Keine Plugin-Updates am Wochenende. Keine gehackte Seite am Montag.
HugoCMS gibt dir die bequeme Redaktion, die du von WordPress kennst — und darunter
die Geschwindigkeit und Sicherheit einer statischen [Hugo](https://gohugo.io)-Seite.

[![Mit der Seite reden](https://img.shields.io/badge/neu-mit%20deiner%20Seite%20reden-8a2be2)](#-sag-deiner-seite-was-sie-tun-soll)
[![PHP 8.1+](https://img.shields.io/badge/PHP-8.1%2B-777bb4)](https://www.php.net)
[![Hugo extended](https://img.shields.io/badge/l%C3%A4uft%20auf-Hugo-ff4088)](https://gohugo.io)
[![Kein Build](https://img.shields.io/badge/Installation-ohne%20Node%2Fnpm-2ea44f)](#in-drei-minuten-live)
[![Rolling Release](https://img.shields.io/badge/Updates-rolling-blue)](#immer-aktuell)

> _Hier gehört ein Screenshot oder ein kurzes GIF hin — die Redaktionsoberfläche mit
> dem Veröffentlichen-Knopf. Ein Bild verkauft dieses Produkt in zwei Sekunden._

---

## Warum HugoCMS?

Du willst Inhalte pflegen — nicht einen Server administrieren.

WordPress hat dir das nie ganz gegeben: eine Datenbank, die kippt. Plugins, die
sich streiten. Sicherheitslücken, die dich zum Update zwingen, bevor jemand die
Seite übernimmt. Ladezeiten, die mit jedem Plugin schlechter werden. Hosting, das
mehr kostet, je mehr Besucher du hast.

**Statische Seiten lösen das alles — nur war Redaktion bisher etwas für die
Kommandozeile.** Genau diese Lücke schließt HugoCMS. Du schreibst im Browser,
drückst einen Knopf, und Hugo baut deine komplette Seite in Sekunden neu. Was
online geht, ist reines HTML: nichts, was ein Angreifer ausführen könnte, nichts,
das eine Datenbank abfragen muss.

| | WordPress | **HugoCMS** |
|---|---|---|
| **Was liegt online** | PHP + Datenbank, live bei jedem Klick | fertiges HTML, vorab gebaut |
| **Angriffsfläche** | Core, Themes, Dutzende Plugins | keine — es läuft nichts auf dem Server |
| **Ladezeit** | „kommt drauf an" | Millisekunden, weltweit cachebar |
| **Hosting** | PHP-Datenbank-Server nötig | einfachster Speicherplatz genügt |
| **Pflichtupdates** | ständig, sicherheitskritisch | keine — statisches HTML altert nicht |
| **Backup** | Datenbank-Dump + Dateien | ein Ordner mit Textdateien |

Für dich als Agentur oder Freelancer heißt das: **eine Installation verwaltet
beliebig viele Kundenseiten** — ein Login, saubere Trennung, ein Skriptaufruf pro
neuer Seite.

## Das kann HugoCMS

### 🗣️ Sag deiner Seite, was sie tun soll

**Das ist der Teil, den kein anderes CMS hat.** Hinterlege einen
Anthropic-Schlüssel, und du bedienst deine Seite in normalen Sätzen:

> „Ändere die Öffnungszeiten auf 9:00 bis 23:00 Uhr."
> „Schreib einen Blogbeitrag über unser neues Winterangebot."
> „Übersetz die Startseite ins Englische."

Der Claude-Assistent kennt Hugo und arbeitet direkt in den Dateien deiner Seite —
er findet die richtige Stelle, ändert sie und zeigt dir das Ergebnis. Alles im
Rahmen genau derselben Grenzen wie du selbst. Du entscheidest, ob er nur liest,
jede Änderung vorher vorlegt oder direkt loslegt; pro Seite kannst du ihm sogar
einen eigenen Stil-Leitfaden mitgeben („Front Matter immer als YAML", „Inhalte
auf Deutsch"). _(optional — braucht einen Anthropic-API-Schlüssel)_

**Redaktion, die sich anfühlt wie ein Textprogramm.**
Lieber selbst tippen? Markdown lässt sich visuell bearbeiten — Überschriften,
Links, Bilder, ohne Syntax lernen zu müssen. Das Front Matter (der technische Kopf
jeder Seite) bleibt dabei geschützt, damit nichts kaputtgeht. Mehrere Personen?
HugoCMS bewahrt dich davor, versehentlich die Änderung eines anderen zu
überschreiben.

**Veröffentlichen ist ein Knopfdruck.**
Ein Klick baut die ganze Seite neu und stellt sie live. Hugos Ergebnis —
Statistik oder Fehlermeldung — erscheint sofort. Kein SSH, kein Deploy-Skript,
kein Warten.

**Versionsgeschichte wie bei den Profis.** _(Pro)_
Volle Git-Versionierung pro Seite: Was hat sich geändert, wer, wann — Verlauf,
Diff, Commit, Push, alles über einen Knopf. Jede Veröffentlichung wird
nachvollziehbar, jeder Stand wiederherstellbar.

**Und der ganze Redaktionsalltag drumherum.**
Inhalte, Vorlagen und Medien getrennt und aufgeräumt. Hochladen per
Ziehen-und-Ablegen, Bildvorschauen, Papierkorb mit Wiederherstellung, Suche über
die ganze Seite. Anmeldung und Einstellungen jederzeit im Browser änderbar.

## In drei Minuten live

HugoCMS ist das **fertig gebaute Auslieferungspaket** — auf den Server laden,
einrichten, fertig. Kein Node, kein npm, kein Build.

```bash
# 1. Paket außerhalb des Webroots ablegen
git clone <DIESE-REPO-URL> /pfad/zu/hugocms-release
cd /pfad/zu/hugocms-release

# 2. Seite einrichten:  bin/install.sh <host> <hugo-publish-ordner>
bin/install.sh kunde-a.example.com /var/www/kunde-a/public

# 3. Im Browser öffnen und Konto anlegen
#    → https://kunde-a.example.com/edit/
```

Beim ersten Aufruf legst du im Browser Anmeldename und Passwort fest — danach bist
du drin. Jede weitere Seite: `bin/install.sh` erneut aufrufen. Das war's.

> **Läuft, wo andere CMS nicht laufen.** Keine Symlinks, keine Sonderrechte,
> keine Datenbank — HugoCMS funktioniert sogar auf einfachem Shared Hosting
> (z. B. Hetzner Webhosting). Hugo selbst? Lädt das Einrichtungs-Skript bei Bedarf
> automatisch in der passenden Version.

## Systemvoraussetzungen

| | |
|---|---|
| **PHP** | 8.1+, als Webserver-Modul oder über PHP-FPM |
| **Erweiterungen** | `fileinfo` (meist vorhanden); `gd` empfohlen für verkleinerte Bildvorschauen |
| **Webserver** | Apache, Nginx oder anderer PHP-fähiger Server — **ohne Symlinks**, läuft auf Shared Hosting |
| **Zugang** | SSH zum einmaligen Einrichten; dort die üblichen Werkzeuge (`bash`, `git`, `curl`/`wget`, `sha256sum`, `tar`) |
| **Hugo** | wird bei Bedarf automatisch heruntergeladen (*extended*) |
| **Optional — KI** | Anthropic-API-Schlüssel |
| **Optional — Pro** | `git` auf dem Server; das Hugo-Projekt ist ein Git-Repository |

## So richtest du eine Seite ein

```bash
bin/install.sh <host> <hugo-publish-ordner>
# z. B.
bin/install.sh kunde-a.example.com /var/www/kunde-a/public
```

- **`<host>`** — der reine Hostname, wie der Browser ihn sendet: ohne `https://`,
  ohne Port, ohne Pfad.
- **`<hugo-publish-ordner>`** — das Verzeichnis, in das Hugo die fertige Seite
  schreibt. Dessen **Elternverzeichnis** ist das Hugo-Projekt; dort liegen bzw.
  entstehen `content/`, `layouts/` und `static/`.

Das Skript erledigt alles in einem Durchgang:

1. **Hugo bereitstellen** — fehlt es, wird es geladen und die Prüfsumme geprüft.
2. **Zugänge anlegen** — für diese Seite: das ganze Projekt sowie die
   Direktzugänge *Inhalt* (`content/`), *Vorlagen* (`layouts/`) und *Medien*
   (`static/`).
3. **Oberfläche ausliefern** — Redaktion unter `/edit/`, API unter `/cms-api/`.
   Ohne Symlinks; der PHP-Code bleibt sicher im Release-Repo.

Danach ist die Seite unter **`https://<host>/edit/`** erreichbar. Beim ersten
Aufruf legst du dein Konto an.

> **Ein Login für alles.** Anmeldename und Passwort gelten installationsweit —
> alle Seiten teilen sich das Backend. Getrennt bleiben nur die Datei-Zugänge je
> Seite. Ideal, um viele Kundenseiten aus einer Hand zu betreuen.

<a name="immer-aktuell"></a>
## Immer aktuell

HugoCMS ist ein **Rolling Release** — fortlaufende Verbesserungen, keine
Versionssprünge. Aktualisieren geht in einer Zeile:

```bash
bin/update.sh              # git pull + Oberfläche aller Seiten neu ausliefern
bin/update.sh --no-pull    # nur ausliefern
bin/update.sh --dry-run    # nur anzeigen, was geschähe
```

## Sicher aus Prinzip

- Der PHP-Code liegt **außerhalb des Webroots** — öffentlich sind nur `edit/` und
  `cms-api/`.
- Jeder Zugang ist auf sein Verzeichnis eingesperrt; ein Ausbruch über `..` ist
  ausgeschlossen.
- Jede Aktion verlangt eine Anmeldung; Schreibaktionen sind zusätzlich gegen
  CSRF geschützt.
- Geheimnisse (Passwort-Hash, API-Schlüssel) verlassen das Backend nie und
  erscheinen in keinem Formular. Enthält die Konfiguration einen Schlüssel,
  schütze die Datei mit `0640`.

Und weil online nur statisches HTML liegt, gibt es schlicht **nichts, was ein
Angreifer ausführen könnte** — die stärkste Sicherheitsmaßnahme ist die, die man
gar nicht erst braucht.

## Hilfe bei Startproblemen

| Symptom | Abhilfe |
|---|---|
| **Anmeldung schlägt fehl / Hinweis zum Sitzungsverzeichnis** | `backend/var/sessions` muss für den Webserver-Benutzer beschreibbar sein — HugoCMS sagt das vor dem Login im Klartext. |
| **HTTP 500** | Meist ein fehlender oder nicht lesbarer Zugangs-Pfad. Log-Stufe (Zahnrad → Log) auf `debug`, Aktion wiederholen, `backend/log/hugocms.log` lesen. Log leer? Dann Server-Log prüfen (z. B. fehlende PHP-Erweiterung). |
| **Veröffentlichen-Knopf fehlt** | Hugo ist nicht eingerichtet — Skript erneut ausführen oder Hugo-Pfad im Zahnrad prüfen. |
| **Alte Oberfläche nach Update** | `bin/update.sh` ausführen und Browser-Zwischenspeicher leeren. |

---

**Quellcode & Entwicklung:** [hugoeditor/hugocms](https://github.com/hugoeditor/hugocms) · **Angetrieben von:** [Hugo](https://gohugo.io)

_HugoCMS — schreib deine Inhalte. Um den Rest kümmert sich der Knopf._
