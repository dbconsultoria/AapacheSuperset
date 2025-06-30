FROM apache/superset:3.0.1

# Atualiza e instala pacotes essenciais
USER root
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    libsasl2-dev \
    libldap2-dev \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Otimizações de ambiente
ENV SUPERSET_ENV=production \
    SUPERSET_LOAD_EXAMPLES=no \
    SUPERSET_CONFIG_PATH=/app/superset_config.py \
    PYTHONUNBUFFERED=1 \
    GUNICORN_TIMEOUT=60 \
    GUNICORN_WORKERS=4 \
    GUNICORN_THREADS=2 \
    GUNICORN_MAX_REQUESTS=1000

# Configuração customizada (opcional, veja exemplo abaixo)
COPY superset_config.py /app/superset_config.py

# Inicializa o banco de dados e assets
RUN superset db upgrade && \
    superset init && \
    superset fab create-admin \
        --username admin \
        --firstname Admin \
        --lastname User \
        --email admin@superset.com \
        --password admin

# Expõe a porta padrão
EXPOSE 8088

# Inicia o servidor usando gunicorn para melhor performance
CMD ["gunicorn", \
     "--workers=4", \
     "--threads=2", \
     "--timeout=60", \
     "-b", "0.0.0.0:8088", \
     "superset.app:create_app()"]
