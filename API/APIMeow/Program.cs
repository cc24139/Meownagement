using System.Text;
using APIMeow.Controllers;
using APIMeow.Tokens;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.JsonWebTokens;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddTransient<TokenJWTUsuario>(); //Injeção de Depedência
// Adiciona o contexto do banco de dados
builder.Services.AddDbContext<DBMeownagement>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var keys = Encoding.ASCII.GetBytes(Configuration.PrivateKey);
builder.Services.AddControllersWithViews();
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(keys),
        ValidateIssuer = false,
        ValidateAudience = false
    };
}
);

// Adiciona o suporte para endpoints da API e Swagger. Opcional.
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline. Opcional.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseAuthentication();
app.UseAuthorization();
app.UseHttpsRedirection();

// Mapeamento dos endpoints da API

// GET: /Usuarios (Listar todos os Usuarios)
app.MapGet("/Usuarios", async (DBMeownagement db) =>
    await db.Usuario.ToListAsync());

// GET: /Usuarios/{id} (Buscar um Usuario por ID)
app.MapGet("/Usuarios/{id}", async (int id, DBMeownagement db) =>
    await db.Usuario.FindAsync(id) is Usuario Usuario ? Results.Ok(Usuario) : Results.NotFound());

// POST: /Usuarios (Criar um novo Usuario)
app.MapPost("/Usuarios", async (Usuario Usuario, DBMeownagement db) =>
{
    db.Usuario.Add(Usuario);
    await db.SaveChangesAsync();
    return Results.Created($"/Usuarios/{Usuario.IdUsuario}", Usuario);
});

// PUT: /Usuarios/{id} (Atualizar um Usuario existente)
app.MapPut("/Usuarios/{id}", async (int id, Usuario UsuarioAtualizado, DBMeownagement db) =>
{
    var Usuario = await db.Usuario.FindAsync(id);
    if (Usuario is null) return Results.NotFound();
    Usuario.Nome = UsuarioAtualizado.Nome;
    await db.SaveChangesAsync();
    return Results.NoContent();
});

// DELETE: /Usuarios/{id} (Excluir um Usuario)
app.MapDelete("/Usuarios/{id}", async (int id, DBMeownagement db) =>
{
    var Usuario = await db.Usuario.FindAsync(id);
    if (Usuario is null) return Results.NotFound();
    db.Usuario.Remove(Usuario);
    await db.SaveChangesAsync();
    return Results.NoContent();
});

app.Run();