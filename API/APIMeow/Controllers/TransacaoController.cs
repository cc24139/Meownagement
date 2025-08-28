using System.Security.Claims;
using APIMeow.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[ApiController]
[Route("v1")]

public class TransacaoController : ControllerBase
{
    //200
    [Authorize]
    [HttpGet("transacoes/listar")]
    public async Task<IActionResult> GetTransacoes(DBMeownagement db)
    {
        var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var listTransacoes = await db.Transacao.Where(t => t.IdUsuario.ToString() == id).ToListAsync();
        return Ok(listTransacoes);
    }
        //200
    [Authorize]
    [HttpGet("transacoes/listarPositivo")]
    public async Task<IActionResult> GetTransacoesPositivas(DBMeownagement db)
    {
        var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var listTransacoes = await db.Transacao.Where(t => t.IdUsuario.ToString() == id && t.QuantiaDinheiro > 0).ToListAsync();
        return Ok(listTransacoes);
    }

    //200
    [Authorize]
    [HttpGet("transacoes/listarNegativo")]
    public async Task<IActionResult> GetTransacoesNegativas(DBMeownagement db)
    {
        var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var listTransacoes = await db.Transacao.Where(t => t.IdUsuario.ToString() == id && t.QuantiaDinheiro < 0).ToListAsync();
        return Ok(listTransacoes);
    }

    //204
    [Authorize]
    [HttpPatch("transacoes/editar")]
    public async Task<IActionResult> EditarTransacao(Transacao transacao, DBMeownagement db)
    {
        var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (usuarioId != transacao.IdUsuario.ToString())
        {
            return BadRequest("Usuário não autorizado a editar esta transação.");
        }
        db.Entry(transacao).State = EntityState.Modified;
        await db.SaveChangesAsync();

        return NoContent();
    }
    //204
    [Authorize]
    [HttpDelete("transacoes/deletar/{id}")]
    public async Task<IActionResult> DeletarTransacao(int id, DBMeownagement db)
    {
        var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var transacao = await db.Transacao.FindAsync(id);
        if (transacao == null)
        {
            return NotFound();
        }
        if (usuarioId != transacao.IdUsuario.ToString())
        {
            return BadRequest("Usuário não autorizado a deletar esta transação.");
        }
        db.Transacao.Remove(transacao);
        await db.SaveChangesAsync();

        return NoContent();
    }
    [Authorize]
    [HttpPost("transacoes/inserir")]
    public async Task<IActionResult> InserirTransacao(TransacaoViewModel model, DBMeownagement db)
    {
        var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (db.Usuario.Find(int.Parse(usuarioId)) == null)
        {
            return BadRequest("Usuário não encontrado.");
        }
        db.Transacao.Add(new Transacao
        {
            Nome = model.Nome,
            QuantiaDinheiro = model.QuantiaDinheiro,
            DataCriacao = model.DataCriacao,
            Feita = model.Feita,
            SaldoAtual = model.SaldoAtual,
            DataFinalizacao = model.DataFinalizacao,
            IdUsuario = int.Parse(usuarioId),
            IdClassificacao = model.IdClassificacao,
            IdRecorrencia = model.IdRecorrencia
        });
        await db.SaveChangesAsync();
        return Ok("Transação criada com sucesso");
    }

    [Authorize]
    [HttpGet("transacao/atualizar")]
    public async Task<IActionResult> AtualizarTransacoes(DBMeownagement db)
    {
        var qtsAtualizadas = 0;
        var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var usuarioAtual = await db.Usuario.FindAsync(int.Parse(usuarioId));
        var transacoesPendentes = await db.Transacao
            .Where(t => t.IdUsuario.ToString() == usuarioId && !t.Feita && t.DataFinalizacao == DateTime.Now && t.DataFinalizacao != t.DataCriacao)
            .ToListAsync();

        foreach (var transacao in transacoesPendentes)
        {
            transacao.Feita = true;
            transacao.SaldoAtual = transacao.QuantiaDinheiro + usuarioAtual.Saldo;
            usuarioAtual.Saldo += transacao.QuantiaDinheiro;
            if (await GerarNovaTransacao(transacao, db))
                qtsAtualizadas++;
        }

        await db.SaveChangesAsync();
        return Ok($"{qtsAtualizadas} transações atualizadas e saldo do usuário ajustado.");
    }

    private async Task<bool> GerarNovaTransacao(Transacao transacaoAntiga, DBMeownagement db)
    {
        try
        {
            DateTime novaDataFinalizacao = transacaoAntiga.DataFinalizacao;
            novaDataFinalizacao.AddDays(transacaoAntiga.Recorrencia.QtsDias);
            novaDataFinalizacao.AddMonths(transacaoAntiga.Recorrencia.QtsMeses);
            novaDataFinalizacao.AddYears(transacaoAntiga.Recorrencia.QtsAnos);

            db.Transacao.Add(new Transacao
            {
                Nome = transacaoAntiga.Nome,
                QuantiaDinheiro = transacaoAntiga.QuantiaDinheiro,
                DataCriacao = transacaoAntiga.DataFinalizacao,
                Feita = false,
                SaldoAtual = transacaoAntiga.SaldoAtual,
                DataFinalizacao = novaDataFinalizacao,
                IdUsuario = transacaoAntiga.IdUsuario,
                IdClassificacao = transacaoAntiga.IdClassificacao,
                IdRecorrencia = transacaoAntiga.IdRecorrencia
            });
            await db.SaveChangesAsync();
            return true;
        }
        catch
        {
            return false;
        }
    }
        [Authorize]
        [HttpPost("transacao/saldo")]
        public async Task<IActionResult> AtualizarSaldo(Transacao transacao, DBMeownagement db)
        {
            if (transacao.DataFinalizacao == DateTime.Now && !transacao.Feita)
        {
            var usuario = await db.Usuario.FindAsync(transacao.IdUsuario);
            usuario.Saldo += transacao.QuantiaDinheiro;
            transacao.Feita = true;
            transacao.SaldoAtual = usuario.Saldo;
            await db.SaveChangesAsync();
            return Ok("Saldo Atualizado");
        }
            return BadRequest("Transação não pode ser atualizada");
        }
    }
