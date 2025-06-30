# Arquivo: superset_config.py

ROW_LIMIT = 5000
SUPERSET_WEBSERVER_TIMEOUT = 60

# Cache local em memória para melhor performance
CACHE_CONFIG = {
    'CACHE_TYPE': 'SimpleCache',
    'CACHE_DEFAULT_TIMEOUT': 300
}

# Desativa logs detalhados
ENABLE_TIME_ROTATE = False
