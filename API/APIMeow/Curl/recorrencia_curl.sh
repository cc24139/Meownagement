# Recorrências - comandos cURL (bash)
# Base URL: https://cookiebeco.roney.stein.nom.br
# Uso: importe no Insomnia ou rode no bash. Substitua ._token pelo token JWT.

### Listar recorrências (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/recorrencia/listar" \
  -H "Authorization: Bearer ._token"

### Obter recorrência por id (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/recorrencia/3" \
  -H "Authorization: Bearer ._token"

### Deletar recorrência (autorizado)
curl -X DELETE "https://cookiebeco.roney.stein.nom.br/v1/recorrencia/deletar/3" \
  -H "Authorization: Bearer ._token"

### Criar recorrência (autorizado) - POST
curl -X POST "https://cookiebeco.roney.stein.nom.br/v1/recorrencia/criar" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ._token" \
  -d '{ "QtsDias": 7, "QtsMeses": 0, "QtsAnos": 0 }'
