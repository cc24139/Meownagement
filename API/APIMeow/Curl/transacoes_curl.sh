# Transações - comandos cURL (bash)
# Base URL: https://cookiebeco.roney.stein.nom.br
# Uso:
#  - Importe qualquer bloco cURL (bash) para o Insomnia via Import -> Paste Raw Text.
#  - Para requests autorizadas, obtenha o token via login e substitua ._token.
#  - Também incluí exemplos PowerShell comentados abaixo.

### 1) Listar transações do usuário (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/transacoes/listar" \
  

### 2) Listar transações recorrentes (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/transacoes/listar/recorrentes" \
  

### 3) Listar transações por data específica (autorizado)
# data no formato ISO (ex: 2025-10-13)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/transacoes/listar/2025-10-13" \
  

### 4) Listar transações por período (autorizado)
# dataInicio e dataFim no formato ISO
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/transacoes/listar/2025-10-01/2025-10-31" \
  

### 5) Listar transações positivas (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/transacoes/listar/positivo" \
  

### 6) Listar transações negativas (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/transacoes/listar/negativo" \
  

### 7) Editar transação (autorizado) — PATCH
# Body: EditTransacaoViewModel (verifique campos no projeto - geralmente IdTransacao, Nome, QuantiaDinheiro, DataCriacao, Feita, DataFinalizacao, IdClassificacao, IdRecorrencia, IdMeta, IdCofrinho)
curl -X PATCH "https://cookiebeco.roney.stein.nom.br/v1/transacoes/editar" \
  -H "Content-Type: application/json" \
   \
  -d '{ "IdTransacao": 123, "Nome": "Pagamento X", "QuantiaDinheiro": -50.0, "DataCriacao": "2025-10-01T12:00:00", "Feita": "N", "DataFinalizacao": "2025-10-15T00:00:00", "IdClassificacao": 2, "IdRecorrencia": null, "IdMeta": null, "IdCofrinho": null }'

### 8) Deletar transação (autorizado)
curl -X DELETE "https://cookiebeco.roney.stein.nom.br/v1/transacoes/deletar/123" \
  

### 9) Criar transação (autorizado) — POST
# Body: TransacaoViewModel: Nome, QuantiaDinheiro, Feita (char 'S'/'N'), DataFinalizacao (string ISO), IdClassificacao, IdRecorrencia, IdMeta?, IdCofrinho?
curl -X POST "https://cookiebeco.roney.stein.nom.br/v1/transacoes/criar" \
  -H "Content-Type: application/json" \
   \
  -d '{ "Nome": "Compra mercado", "QuantiaDinheiro": -120.50, "Feita": "N", "DataFinalizacao": "2025-10-20T00:00:00", "IdClassificacao": 1, "IdRecorrencia": null, "IdMeta": null, "IdCofrinho": null }'

### 10) Atualizar transações com data de hoje (autorizado)
curl -X GET "https://cookiebeco.roney.stein.nom.br/v1/transacao/atualizar" \
  

# -------------------------
# Exemplos PowerShell (equivalentes)
# Use estes no PowerShell se preferir:

# Exemplo: Listar transações (PowerShell)
# $TOKEN = "._token"
# curl -Method GET -Uri "https://cookiebeco.roney.stein.nom.br/v1/transacoes/listar" -Headers @{ "Authorization" = "Bearer $TOKEN" }

# Exemplo: Criar transação (PowerShell)
# $body = '{ "Nome": "Compra mercado", "QuantiaDinheiro": -120.50, "Feita": "N", "DataFinalizacao": "2025-10-20T00:00:00", "IdClassificacao": 1, "IdRecorrencia": null, "IdMeta": null, "IdCofrinho": null }'
# curl -Method POST -Uri "https://cookiebeco.roney.stein.nom.br/v1/transacoes/criar" -Headers @{ "Content-Type" = "application/json"; "Authorization" = "Bearer $TOKEN" } -Body $body

# FIM
