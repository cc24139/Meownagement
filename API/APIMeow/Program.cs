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
DotNetEnv.Env.Load();
//Ligando a autorização do token  com base na key
var keys = Encoding.ASCII.GetBytes(Configuration.PrivateKey);
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
builder.Services.AddAuthorization();

// Adiciona o suporte para endpoints da API e Swagger. Opcional.
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddControllers();
var app = builder.Build();
app.MapControllers();

// Configure the HTTP request pipeline. Opcional.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseAuthentication();
app.UseAuthorization();
app.UseHttpsRedirection();




app.Run("Olá desenvolvedor, a API está rodando! 🐈‍⬛");