# Cofrinhos - comandos cURL (bash)
# Base URL: https://cookiebeco.roney.stein.nom.br
# Uso: importe no Insomnia ou rode no bash. Substitua COLE_AQUI_SEU_TOKEN pelo token JWT.

### Listar cofrinhos (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/cofrinho/listar" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar cofrinhos concluídos (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/cofrinho/listarConcluidos" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar cofrinhos não concluídos (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/cofrinho/listarNaoConcluidos" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar por data (autorizado) - forneça data ISO
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/cofrinho/listar/2025-10-13" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar ganho total e cofrinhos (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/cofrinho/listarGanho" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Criar cofrinho (autorizado) - PUT
curl -X PUT "https://cookiebeco.roney.stein.nom.br/v1/cofrinho/criar" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN" \
  -d '{ "Nome": "Poupanca X", "Economia": 500.00, "DataCriacao": "2025-10-01T00:00:00", "DataTermino": "2025-12-31T00:00:00", "Feita": "N", "IdClassificacao": 1 }'

### Deletar cofrinho (autorizado)
curl -X DELETE "https://cookiebeco.roney.stein.nom.br/v1/cofrinho/deletar/10" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Concluir cofrinho (autorizado) - PATCH
curl -X PATCH "https://cookiebeco.roney.stein.nom.br/v1/cofrinho/concluir/10" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

# PowerShell exemplos (comentados)
# $TOKEN = "COLE_AQUI_SEU_TOKEN"
# curl -Method PUT -Uri "https://cookiebeco.roney.stein.nom.br/v1/cofrinho/criar" -Headers @{ "Content-Type" = "application/json"; "Authorization" = "Bearer $TOKEN" } -Body $body
