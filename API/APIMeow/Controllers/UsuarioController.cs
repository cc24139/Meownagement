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
        return Ok(usuarios);
    }
    
    [HttpPost]
    [Route("usuarios/cadastrar")]
    public async Task<IActionResult> CadastrarUsuario([FromBody] CreateUserViewModel userModel, DBMeownagement db)
    {
       if(!ModelState.IsValid || string.IsNullOrEmpty(userModel.Nome) || string.IsNullOrEmpty(userModel.Email) || string.IsNullOrEmpty(userModel.Senha))
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
            Senha = userModel.Senha,
            Pontos = 500,
            Saldo = 0,
        };
        await senhaHash.RegistrarUsuarioAsync(usuario);
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
        if(!string.IsNullOrEmpty(model.Senha))
        {
           usuarioExistente.Senha = Hash.HashPassword(usuarioExistente, model.Senha);
        }
        if(!string.IsNullOrEmpty(model.Nome))
        {
           usuarioExistente.Nome = model.Nome;
        }
        await db.SaveChangesAsync();
        return Ok(usuarioExistente);
    }
}