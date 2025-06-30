#!/bin/bash

set -e  # encerra o script se algum comando falhar, exceto onde tratado

echo "🔄 Aguardando o banco de dados estar pronto..."

# Espera ativa com timeout opcional (pode ser substituído por healthcheck real)
sleep 10

echo "✅ Inicializando o Superset..."

# Aplica migrações no banco
superset db upgrade

# Cria usuário admin, ignora erro se já existir
superset fab create-admin \
    --username "${SUPERSET_ADMIN_USERNAME:-admin}" \
    --firstname "${SUPERSET_ADMIN_FIRSTNAME:-Admin}" \
    --lastname "${SUPERSET_ADMIN_LASTNAME:-User}" \
    --email "${SUPERSET_ADMIN_EMAIL:-admin@superset.com}" \
    --password "${SUPERSET_ADMIN_PASSWORD:-admin}" || true

# Inicializa os assets e roles
superset init

echo "🚀 Iniciando o servidor Superset..."

# Inicia o servidor Gunicorn escutando na porta correta
exec gunicorn \
    --workers=4 \
    --threads=2 \
    --timeout=60 \
    -b 0.0.0.0:8088 \
    "superset.app:create_app()"
