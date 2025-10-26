# Metas - comandos cURL (bash)
# Base URL: https://cookiebeco.roney.stein.nom.br
# Uso: importe no Insomnia ou rode no bash. Substitua COLE_AQUI_SEU_TOKEN pelo token JWT.

### Listar metas (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/metas/listar" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar metas concluídas (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/metas/listarConcluidas" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar metas não concluídas (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/metas/listarNaoConcluidas" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar metas por classificação (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/metas/listar/classificacao/1" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar metas por data (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/metas/listar/data/2025-10-01" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar metas por período (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/metas/listar/periodo/2025-10-01/2025-10-31" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar quanto foi gasto por metas (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/metas/listarQuantosGastos" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Mostrar valor gasto de meta por id (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/metas/mostrarValorGasto/5" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Criar meta (autorizado) - POST
curl -X POST "https://cookiebeco.roney.stein.nom.br/v1/metas/criar" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN" \
  -d '{ "Nome": "Férias", "GastoLimite": 2000.00, "DataCriacao": "2025-10-01T00:00:00", "DataTermino": "2026-03-01T00:00:00", "Feita": "N", "IdClassificacao": 1 }'

### Deletar meta (autorizado)
curl -X DELETE "https://cookiebeco.roney.stein.nom.br/v1/metas/deletar/5" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Concluir meta (autorizado) - PATCH
curl -X PATCH "https://cookiebeco.roney.stein.nom.br/v1/metas/Concluir/5" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"
