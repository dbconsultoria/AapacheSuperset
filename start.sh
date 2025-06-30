#!/bin/bash

# Aguarda o banco de dados estar pronto (ajuste host e porta se necessário)
echo "Aguardando o banco de dados..."
sleep 10

# Inicialização
superset db upgrade
superset fab create-admin \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@superset.com \
    --password admin || true  # ignora se o usuário já existir
superset init

# Inicia o servidor Gunicorn
exec gunicorn \
    --workers=4 \
    --threads=2 \
    --timeout=60 \
    -b 0.0.0.0:8088 \
    "superset.app:create_app()"
