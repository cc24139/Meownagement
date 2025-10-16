# LoginDiario - comandos cURL (bash)
# Base URL: https://cookiebeco.roney.stein.nom.br
# Uso: importe no Insomnia ou rode no bash. Substitua COLE_AQUI_SEU_TOKEN pelo token JWT.

### Listar logins diários (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/loginDiario/listar" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Atualizar login diário (autorizado) - PATCH
curl -X PATCH "https://cookiebeco.roney.stein.nom.br/v1/loginDiario/atualizar" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

# PowerShell exemplos (comentados)
# $TOKEN = "COLE_AQUI_SEU_TOKEN"
# curl -Method PATCH -Uri "https://cookiebeco.roney.stein.nom.br/v1/loginDiario/atualizar" -Headers @{ "Authorization" = "Bearer $TOKEN" }
