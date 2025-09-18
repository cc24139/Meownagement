using System.Security.Claims;
using APIMeow.Controllers;
using APIMeow.Email;
using APIMeow.Hash;
using APIMeow.Models;
using APIMeow.Tokens;
using APIMeow.ViewModels;
using APIMeow.ViewModels.Verify;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[ApiController]
[Route("v1")]
public class UsuarioController : ControllerBase
{
    [HttpPost]
    [Route("usuarios/login")]
    public async Task<IActionResult> Login([FromBody] LoginViewModel Login, DBMeownagement db)
    {
        if (string.IsNullOrEmpty(Login.Login) || string.IsNullOrEmpty(Login.Senha))
        {
            return BadRequest("Campos Inválidos!");
        }
        var user = await db.Usuario
            .FirstOrDefaultAsync(u => u.Email == Login.Login);
        var hash = new PasswordHasher<Usuario>();

        if (user == null)
        {
            return Unauthorized("Usuário ou senha inválidos.");
        }
        var verifica = hash.VerifyHashedPassword(user, user.Senha, Login.Senha);
        if (verifica == PasswordVerificationResult.Failed)
        {
            return Unauthorized("Usuário ou senha inválidos.");
        }
        var token = new TokenJWTUsuario();
        return Ok(new { Token = token.Generate(user) });
    }

    [Authorize]
    [HttpGet]
    [Route("usuarios/listar")]
    public async Task<IActionResult> ListarUsuarios(DBMeownagement db)
    {
        var usuarios = await db.Usuario.AsNoTracking().ToListAsync();
        if (usuarios == null || !usuarios.Any())
        {
            return NotFound("Nenhum usuário encontrado.");
        }
        return Ok(usuarios.Select(u => new { u.IdUsuario, u.Nome, u.Email, u.Pontos, u.Saldo }));
    }

    [Authorize]
    [HttpGet("usuarios/pesquisar")]
    public async Task<IActionResult> PesquisarUsuarios([FromQuery] string nome, DBMeownagement db)
    {
        if (string.IsNullOrEmpty(nome))
        {
            return BadRequest("Nome inválido.");
        }
        var usuarios = await db.Usuario
            .AsNoTracking()
            .Where(u => u.Nome.Contains(nome))
            .ToListAsync();
        if (usuarios == null || !usuarios.Any())
        {
            return NotFound("Nenhum usuário encontrado.");
        }
        return Ok(usuarios.Select(u => new { u.IdUsuario, u.Nome, u.Email, u.Pontos, u.Saldo }));
    }

    [Authorize]
    [HttpGet("usuarios/perfil")]
    public async Task<IActionResult> ObterPerfilUsuario(DBMeownagement db)
    {
        var IdUsuario = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
        var usuario = await db.Usuario
            .AsNoTracking()
            .FirstOrDefaultAsync(u => u.IdUsuario == int.Parse(IdUsuario));
        var gatoEquipado = await db.Gatos.Where(g =>
        g.IdGato == db.UsuarioGato.Where(ug => ug.IdUsuario == int.Parse(IdUsuario) && ug.Equipado == 'S')
        .Select(ug => ug.IdGato).FirstOrDefault()).FirstOrDefaultAsync();

        if (usuario == null)
        {
            return NotFound("Usuário não encontrado.");
        }
        return Ok(new { usuario.IdUsuario, usuario.Nome, usuario.Email, usuario.Biografia, usuario.Pontos, usuario.Saldo, gatoEquipado });
    }

    [HttpPost]
    [Route("usuarios/cadastrar")]
    public async Task<IActionResult> CadastrarUsuario([FromBody] CreateUserViewModel userModel, DBMeownagement db)
    {
        if (!ModelState.IsValid || string.IsNullOrEmpty(userModel.Nome) || string.IsNullOrEmpty(userModel.Email) || string.IsNullOrEmpty(userModel.Senha))
        {
            return BadRequest("Nome, email ou senha inválidos.");
        }
        var emailExistente = await db.Usuario.AnyAsync(u => u.Email == userModel.Email);
        if (emailExistente)
        {
            return Conflict("Email já está em uso.");
        }
        
        //caso o usuario já tenha um codigo ativo
        var codigoExistente = await db.CodeEmail.FirstOrDefaultAsync(c => c.Email == userModel.Email);
        if (codigoExistente != null)
        {
            if(codigoExistente.TempoExp > DateTime.Now)
            {
                return BadRequest("Já existe um código de verificação ativo para este email. Verifique sua caixa de entrada e spam.");
            }
            else
            {
                db.CodeEmail.Remove(codigoExistente);
                await db.SaveChangesAsync();
            }
        }
        var verificaEmail = new EmailVerification(userModel.Email);
        await verificaEmail.SendEmail();
        var codeEmail = new CodeEmail
        {
            Code = verificaEmail._codeVerify.ToString(),
            Email = userModel.Email,
            TempoExp = verificaEmail._codeExpire,
            Nome = userModel.Nome,
            Biografia = userModel.Biografia,
            Senha = userModel.Senha,
        };
        await db.CodeEmail.AddAsync(codeEmail);
        await db.SaveChangesAsync();
        return Ok("Código de verificação enviado para o email cadastrado. Verifique sua caixa de entrada e spam.");
    }

    [HttpPost]
    [Route("usuarios/confirmarEmail")]
    public async Task<IActionResult> ConfirmarEmail([FromBody] ConfirmarEmailViewModel model, DBMeownagement db)
    {
        if (string.IsNullOrEmpty(model.Email) || string.IsNullOrEmpty(model.Code))
        {
            return BadRequest("Email ou código inválidos.");
        }
        var codeEntry = await db.CodeEmail.FirstOrDefaultAsync(c => c.Email == model.Email && c.Code == model.Code);
        if (codeEntry == null)
        {
            return NotFound("Código ou email inválidos.");
        }
        if (codeEntry.TempoExp < DateTime.Now )
        {
            db.CodeEmail.Remove(codeEntry);
            await db.SaveChangesAsync();
            return BadRequest("Código expirado. Solicite um novo código.");
        }
        var usuario = new Usuario
        {
            Nome = codeEntry.Nome,
            Email = codeEntry.Email,
            Biografia = codeEntry.Biografia,
            Senha = new PasswordHasher<Usuario>().HashPassword(null, codeEntry.Senha),
            Pontos = 1000,
            Saldo = 0
        };

        await db.Usuario.AddAsync(usuario);
        await db.SaveChangesAsync();

        await db.UsuarioGato.AddAsync(new UsuarioGato
        {
            IdUsuario = usuario.IdUsuario,
            IdGato = 1, //zazu 
            Copias = 1,
            Equipado = 'S'
        });
        await db.LoginDiario.AddAsync(new LoginDiario
        {
            IdUsuario = usuario.IdUsuario,
            NumSequencia = 1,
            UltimoLogin = DateTime.Now
        });
        db.CodeEmail.Remove(codeEntry);
        await db.SaveChangesAsync();
        return Ok("Email confirmado com sucesso.");
    }

    [Authorize]
    [HttpPatch]
    [Route("usuarios/editar")]
    public async Task<IActionResult> EditarUsuario([FromBody] EditarUsuarioViewModel model, DBMeownagement db)
    {

        var IdUsuario = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
        var usuarioExistente = await db.Usuario.FindAsync(int.Parse(IdUsuario));
        var Hash = new PasswordHasher<Usuario>();
        if (usuarioExistente == null)
        {
            return NotFound("Usuário não encontrado.");
        }
        if (usuarioExistente.Pontos < 467 && !string.IsNullOrEmpty(model.Senha))
        {
            return BadRequest($"Você não tem pontos suficientes para alterar a senha. (falta {467 - usuarioExistente.Pontos} pontos necessários)");
        }
        else if (!string.IsNullOrEmpty(model.Senha))
        {
            usuarioExistente.Pontos -= 467;
            usuarioExistente.Senha = model.Senha != null ? Hash.HashPassword(usuarioExistente, model.Senha) : usuarioExistente.Senha;
            usuarioExistente.Biografia = model.Biografia ?? usuarioExistente.Biografia;
            usuarioExistente.Nome = model.Nome ?? usuarioExistente.Nome;
        }
        await db.SaveChangesAsync();
        return Ok(usuarioExistente);
    }

    [HttpPatch]
    [Route("usuarios/esquecerSenha")]
    public async Task<IActionResult> EsquecerSenha([FromBody] EditarUsuarioViewModel model, DBMeownagement db)
    {
        if (string.IsNullOrEmpty(model.Nome) || string.IsNullOrEmpty(model.Senha))
        {
            return BadRequest("Email ou nova senha inválidos.");
        }
        var usuarioExistente = await db.Usuario.FirstOrDefaultAsync(u => u.Email == model.Nome);
        var Hash = new PasswordHasher<Usuario>();
        if (usuarioExistente == null)
        {
            return NotFound("Usuário não encontrado.");
        }
        usuarioExistente.Senha = Hash.HashPassword(usuarioExistente, model.Senha);
        await db.SaveChangesAsync();
        return Ok("Senha alterada com sucesso.");
    }
}