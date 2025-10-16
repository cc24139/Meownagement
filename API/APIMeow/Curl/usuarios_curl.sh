# Usuários - comandos cURL (bash)
# Base URL: https://cookiebeco.roney.stein.nom.br
# Uso: importe no Insomnia ou rode no bash. Substitua COLE_AQUI_SEU_TOKEN pelo token JWT.

### Login (obter token)
curl -X POST "https://cookiebeco.roney.stein.nom.br/v1/usuarios/login" \
  -H "Content-Type: application/json" \
  -d '{ "Login": "seu@email.com", "Senha": "suaSenha" }'

### Listar usuários (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/usuarios/listar" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Pesquisar por nome (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/usuarios/pesquisar?nome=Joao" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Perfil (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/usuarios/perfil" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN"

### Cadastrar (envia código por e-mail)
curl -X POST "https://cookiebeco.roney.stein.nom.br/v1/usuarios/cadastrar" \
  -H "Content-Type: application/json" \
  -d '{ "Nome": "Fulano", "Email": "fulano@example.com", "Biografia": "Gosto de gatos", "Senha": "Senha123!" }'

### Confirmar email (usando código recebido)
curl -X POST "https://cookiebeco.roney.stein.nom.br/v1/usuarios/confirmarEmail" \
  -H "Content-Type: application/json" \
  -d '{ "Email": "fulano@example.com", "Code": "123456" }'

### Reenviar código (PUT) - body é apenas uma string JSON (email)
curl -X PUT "https://cookiebeco.roney.stein.nom.br/v1/usuarios/reenviarCodigo" \
  -H "Content-Type: application/json" \
  -d '"fulano@example.com"'

### Editar usuário (autorizado) - PATCH
curl -X PATCH "https://cookiebeco.roney.stein.nom.br/v1/usuarios/editar" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer COLE_AQUI_SEU_TOKEN" \
  -d '{ "Nome": "NovoNome", "Biografia": "Nova bio" }'

### Esquecer senha (inicia fluxo de recuperação)
curl -X PATCH "https://cookiebeco.roney.stein.nom.br/v1/usuarios/esquecerSenha" \
  -H "Content-Type: application/json" \
  -d '{ "Email": "fulano@example.com", "Senha": "NovaSenha123!" }'

### Confirmar esquecer senha (usar código recebido)
curl -X PATCH "https://cookiebeco.roney.stein.nom.br/v1/usuarios/confirmarEsquecerSenha" \
  -H "Content-Type: application/json" \
  -d '{ "Email": "fulano@example.com", "Code": "123456" }'

# Exemplos PowerShell (comentados) - substitua $TOKEN
# $TOKEN = "COLE_AQUI_SEU_TOKEN"
# curl -Method GET -Uri "https://cookiebeco.roney.stein.nom.br/v1/usuarios/listar" -Headers @{ "Authorization" = "Bearer $TOKEN" }
