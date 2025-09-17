using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace APIMeow.Controllers
{
    [ApiController]
    [Route("v1")]
    public class LoginDiarioController : ControllerBase
    {
        [Authorize]
        [HttpGet("loginDiario/listar")]
        public async Task<IActionResult> ListarLoginsDiarios(DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var loginsDiarios = await db.LoginDiario.Where(ld => ld.IdUsuario == userId).FirstOrDefaultAsync();
            string datas = "";
            for (int i = 0; i < loginsDiarios.NumSequencia; i++)
            {
                var data = new DateTime(loginsDiarios.UltimoLogin.Year, loginsDiarios.UltimoLogin.Month, loginsDiarios.UltimoLogin.Day).AddDays(-i);
                datas += data.ToString("yyyy-MM-dd") + ", ";
            }
            return Ok(datas.Split(", ").Where(d => !string.IsNullOrEmpty(d)).ToList());
        }
        [Authorize]
        [HttpPatch("loginDiario/atualizar")]
        public async Task<IActionResult> AtualizarLoginDiario(DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var usuario = await db.Usuario.FindAsync(userId);
            if (usuario == null)
            {
                return NotFound("Usuário não encontrado.");
            }
            var loginDiario = await db.LoginDiario.Where(ld => ld.IdUsuario == userId).FirstOrDefaultAsync();
            if (!VerificarSeEhMesmoDia(loginDiario.UltimoLogin, DateTime.Now))
            {
                if (PerdeuSequencia(loginDiario.UltimoLogin, DateTime.Now))
                {
                    loginDiario.NumSequencia = 1;
                }
                else
                {
                    loginDiario.NumSequencia += 1;
                }
                loginDiario.UltimoLogin = DateTime.Now;
                int pontosGanhos = 10 + (loginDiario.NumSequencia / 7 * 5);
                if (pontosGanhos > 100)
                {
                    pontosGanhos = 100;
                }
                usuario.Pontos += pontosGanhos;
                await db.SaveChangesAsync();
                return Ok(new { mensagem = $"Login diário atualizado! Você ganhou {pontosGanhos} pontos.", pontosTotais = usuario.Pontos, sequenciaAtual = loginDiario.NumSequencia });
            }
            return BadRequest("Você já fez login hoje.");
        }

        private bool VerificarSeEhMesmoDia(DateTime data1, DateTime data2)
        {
            return data1.Date == data2.Date;
        }
        
        private bool PerdeuSequencia(DateTime ultimaData, DateTime dataAtual)
        {
            return (dataAtual - ultimaData).TotalDays > 1;
        }
    }
}