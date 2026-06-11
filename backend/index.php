<?php
/**
 * HugoCMS – Einstiegspunkt des Backends (Endpunkt /cms-api/).
 *
 * Im Produktivsystem zeigt der Symlink cms-api/ auf dieses backend/-Verzeichnis
 * (siehe bin/install.sh). Der Webserver ruft dann backend/index.php auf, die
 * den festen Einstiegspunkt core/hugocms.php einbindet. custom.php, hugocms.ini
 * und mounts/<hash>.ini werden von dort relativ zu backend/ gesucht.
 */

declare(strict_types=1);

require __DIR__ . '/core/hugocms.php';
