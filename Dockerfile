FROM apache/superset:3.0.1

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

ENV SUPERSET_ENV=production \
    SUPERSET_CONFIG_PATH=/app/superset_config.py \
    PYTHONUNBUFFERED=1

COPY superset_config.py /app/superset_config.py
COPY start.sh /app/start.sh

RUN chmod +x /app/start.sh

EXPOSE 8088

CMD ["/app/start.sh"]
