# Gatos - comandos cURL (bash)
# Base URL: https://cookiebeco.roney.stein.nom.br
# Uso: importe no Insomnia ou rode no bash. Substitua COLE_AQUI_SEU_TOKEN pelo token JWT.

### Listar todos os gatos (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/listar" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar por nome (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/listarNome/Felix" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar por id do gato (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/listarIdGato/5" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar por raridade (autorizado) - query param ?raridade=2
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/listarRaridade?raridade=2" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Obter gato estático (sem auth) - retorna paleta
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/estaticas/3"

### Listar desbloqueados (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/listarDesbloqueados" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Listar bloqueados (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/listarBloqueados" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Roletar (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/roletar" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Roletar 10 vezes (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/roletar/10" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Gato equipado (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/equipado" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Equipar gato (autorizado) - PATCH
curl -X PATCH "https://cookiebeco.roney.stein.nom.br/v1/gatos/equipar/5" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Adicionar gato (autorizado) - POST com body string (Nome)
curl -X POST "https://cookiebeco.roney.stein.nom.br/v1/gatos/adicionar" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN" \
  -d '"Zazu"'

### Obter paleta por id (sem auth)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/paleta/3"

### Obter paleta do usuário (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/gatos/paleta/usuario" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"
