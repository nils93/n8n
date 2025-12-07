#!/bin/bash
set -e

echo "=== [n8n] Starte Setup für lokale Docker-Umgebung ==="

# -------------------------------------------------------------
# 1. Docker-Dienst prüfen/aktivieren (Linux only, Mac ignoriert es)
# -------------------------------------------------------------
if command -v systemctl &>/dev/null; then
    echo "[Docker] Aktiviere Docker-Dienst..."
    sudo systemctl enable --now docker || true
fi

# -------------------------------------------------------------
# 2. Benutzer zur docker-Gruppe hinzufügen (falls nötig)
# -------------------------------------------------------------
if command -v groups &> /dev/null && command -v usermod &> /dev/null; then
    if ! groups "$USER" | grep -q "\bdocker\b"; then
        echo "[Docker] Füge Benutzer '$USER' der docker-Gruppe hinzu..."
        sudo usermod -aG docker "$USER"
        echo " >> TERMINAL neu starten!"
    fi
fi

# -------------------------------------------------------------
# 3. Image bauen
# -------------------------------------------------------------
echo "[Docker] Baue n8n-Container..."
docker compose --env-file ../.env build

# -------------------------------------------------------------
# 4. Container starten
# -------------------------------------------------------------
echo "[Docker] Starte n8n..."
docker compose --env-file ../.env up -d

echo "=== [n8n] Setup abgeschlossen! ==="
echo "n8n läuft nun unter: http://localhost:5678"
echo "Persistente Daten: ../n8n_data/"
echo "Jetzt noch \"tailscale funnel 5678\" freigeben, falls von außen erreichbar sein soll."