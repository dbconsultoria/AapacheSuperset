FROM apache/superset:3.0.1

# Instala apenas os pacotes essenciais para evitar imagem inchada
USER root
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Define variáveis de ambiente
ENV SUPERSET_ENV=production \
    SUPERSET_CONFIG_PATH=/app/superset_config.py \
    PYTHONUNBUFFERED=1

# Copia configurações customizadas e script de inicialização
COPY superset_config.py /app/superset_config.py
COPY start.sh /app/start.sh

# Garante permissões de execução
RUN chmod +x /app/start.sh

# Expõe a porta padrão do Superset
EXPOSE 8088

# Comando que inicia o Superset via start.sh
CMD ["/app/start.sh"]
