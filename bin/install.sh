#!/bin/bash
# install.sh — Richtet eine HugoCMS-Webseite im Produktivsystem ein.
#
# Aufruf:
#     bin/install.sh <host> <hugo-publish-ordner>
#
#   <host>                 Hostname der Webseite OHNE Schema/Port/Pfad,
#                          z. B. kunde-a.example.com (so wie der Browser ihn
#                          sendet). Den Endpunkt-Pfad (/cms-api) ergänzt das
#                          Skript selbst — passend zum Symlink-Namen unten.
#   <hugo-publish-ordner>  Veröffentlichungsverzeichnis von Hugo; hier werden
#                          die Symlinks edit/ und cms-api/ angelegt.
#
# Wirkung:
#   1. Erzeugt — falls noch nicht vorhanden — die host-spezifische Mount-Datei
#        backend/mounts/<hash>.ini   (Hash wie scripts/site-hash.sh)
#      aus der Vorlage mounts.ini.beispiel. Die Mount-Pfade darin anpassen.
#   2. Legt im Publish-Ordner zwei Symlinks an:
#        edit     -> <packaging>/app      (Editor-Oberfläche, URL /edit/)
#        cms-api  -> <packaging>/backend  (API-Endpunkt,       URL /cms-api/)
#
# Das Skript liegt im bin/ des packaging-Repos und ermittelt dessen Wurzel
# relativ zu sich selbst — das Repo darf an beliebiger Stelle liegen.

set -euo pipefail

# --- Namen der Symlinks; API_LINK ist zugleich der Endpunkt-Pfad ------------
EDIT_LINK="edit"     # Symlink auf app/      (Frontend)
API_LINK="cms-api"   # Symlink auf backend/  (API) = Endpunkt-Pfad für den Hash

# --- packaging-Wurzel relativ zum Skript -----------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
APP_DIR="$PKG_ROOT/app"
BACKEND_DIR="$PKG_ROOT/backend"
MOUNTS_DIR="$BACKEND_DIR/mounts"
TEMPLATE="$BACKEND_DIR/mounts.ini.beispiel"

# --- Parameter prüfen ------------------------------------------------------
if [ "$#" -ne 2 ]; then
    echo "Aufruf: $0 <host> <hugo-publish-ordner>" >&2
    echo "  z. B. $0 kunde-a.example.com /var/www/kunde-a/public" >&2
    exit 1
fi

HOST="$1"
PUBLISH="$2"

# Host grob prüfen: kein Schema, kein Port, kein Pfad, kein Leerzeichen.
if printf '%s' "$HOST" | grep -qE '[/:[:space:]]'; then
    echo "❌ <host> darf nur den Hostnamen enthalten (kein Schema/Port/Pfad): '$HOST'" >&2
    exit 1
fi

# Voraussetzungen: packaging-Struktur und Publish-Ordner.
for d in "$APP_DIR" "$BACKEND_DIR"; do
    if [ ! -d "$d" ]; then
        echo "❌ Erwartetes Verzeichnis fehlt: $d" >&2
        echo "   Liegt install.sh wirklich im bin/ des packaging-Repos?" >&2
        exit 1
    fi
done
if [ ! -d "$PUBLISH" ]; then
    echo "❌ Publish-Ordner existiert nicht: $PUBLISH" >&2
    exit 1
fi
PUBLISH_ABS="$(cd "$PUBLISH" && pwd)"

echo "========================================="
echo "HugoCMS - Webseite einrichten"
echo "========================================="
echo "packaging-Repo: $PKG_ROOT"
echo "Webseite:       $HOST"
echo "Publish-Ordner: $PUBLISH_ABS"
echo ""

# --- 0. Hugo bereitstellen -------------------------------------------------
# Das Hugo-Binary wird nicht mitausgeliefert (bin/hugo/ ist ignoriert); beim
# ersten Lauf per get-hugo.sh nachladen.
if [ ! -x "$SCRIPT_DIR/hugo/hugo" ]; then
    echo "0. Hugo-Binary nicht vorhanden — wird heruntergeladen …"
    "$SCRIPT_DIR/get-hugo.sh"
    echo ""
fi

# --- 1. Host-spezifische Mount-Datei ---------------------------------------
# Site-Kennung = Host + Endpunkt-Pfad; Hash identisch zu backend/core/SiteKey.php.
SITE_KEY="${HOST}/${API_LINK}"
HASH="$(printf '%s' "$SITE_KEY" | sha256sum | cut -d' ' -f1)"
MOUNT_FILE="$MOUNTS_DIR/${HASH}.ini"

mkdir -p "$MOUNTS_DIR"
echo "1. Mount-Konfiguration"
echo "   Site-Kennung: $SITE_KEY"
echo "   Datei:        $MOUNT_FILE"
if [ -e "$MOUNT_FILE" ]; then
    echo "   → existiert bereits, bleibt unverändert."
elif [ -f "$TEMPLATE" ]; then
    cp "$TEMPLATE" "$MOUNT_FILE"
    echo "   → aus Vorlage erzeugt. Bitte die Mount-Pfade in der Datei anpassen."
else
    printf '; HugoCMS – Mounts für %s\n; (Vorlage mounts.ini.beispiel fehlte — Mounts ergänzen.)\n' "$HOST" > "$MOUNT_FILE"
    echo "   → leere Datei erzeugt (Vorlage fehlte). Mounts ergänzen."
fi
echo ""

# --- 2. Symlinks im Publish-Ordner -----------------------------------------
# -f: vorhandenen Link ersetzen; -n: bestehenden Verzeichnis-Symlink nicht
#     dereferenzieren (sonst landete der Link IM Zielverzeichnis).
echo "2. Symlinks im Publish-Ordner"
ln -sfn "$APP_DIR"     "$PUBLISH_ABS/$EDIT_LINK"
ln -sfn "$BACKEND_DIR" "$PUBLISH_ABS/$API_LINK"
echo "   $EDIT_LINK/    -> $APP_DIR"
echo "   $API_LINK/ -> $BACKEND_DIR"
echo ""

echo "========================================="
echo "✓ Einrichtung abgeschlossen für $HOST"
echo "========================================="
