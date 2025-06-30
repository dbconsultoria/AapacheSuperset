# superset_config.py - Configurações customizadas para ambiente de produção

# 🔐 Chave secreta para segurança (CSRF, sessões, etc.)
SECRET_KEY = 'QjD96dkmHsqLPyoj48rMsVnK1Usy5Z5kEXyGHZgUkPY='

# 📊 Limite padrão de linhas em consultas
ROW_LIMIT = 5000

# 🌐 Timeout do servidor web em segundos
SUPERSET_WEBSERVER_TIMEOUT = 60

# 🚀 Configuração de cache para acelerar navegação e filtros
CACHE_CONFIG = {
    'CACHE_TYPE': 'SimpleCache',  # Pode ser trocado por Redis para produção maior
    'CACHE_DEFAULT_TIMEOUT': 300  # Tempo de cache em segundos
}

# 🛑 Desativa rotação de logs (pode ser ativado se logs forem muito grandes)
ENABLE_TIME_ROTATE = False

# ✅ Outras boas práticas opcionais (descomente se precisar)
# FEATURE_FLAGS = {
#     "ALERT_REPORTS": True,
#     "DASHBOARD_CROSS_FILTERS": True,
# }

# LOGGING_CONFIG = {
#     # Config custom de logs, se necessário
# }
