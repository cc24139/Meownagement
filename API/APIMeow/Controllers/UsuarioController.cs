using System.Security.Claims;
using APIMeow.Controllers;
using APIMeow.Hash;
using APIMeow.Tokens;
using APIMeow.ViewModels;
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
        var senhaHash = new HashUsuario(db);
        var usuario = new Usuario
        {
            Nome = userModel.Nome,
            Email = userModel.Email,
            Biografia = userModel.Biografia ?? string.Empty,
            Senha = userModel.Senha,
            Pontos = 500,
            Saldo = 0,
        };
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
        await senhaHash.RegistrarUsuarioAsync(usuario);
        await db.SaveChangesAsync();
        return CreatedAtAction(nameof(CadastrarUsuario), new { id = usuario.IdUsuario }, usuario);
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