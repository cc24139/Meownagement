using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using APIMeow.Tokens;
using Microsoft.IdentityModel.Tokens;

namespace APIMeow.Controllers
{
    public class TokenServices
    {
        public string Generate(Usuario user)
        {
            //Instancia o pacote JWT
            var handler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(Configuration.PrivateKey);
            var credencial = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = GeneretaClaims(user),
                SigningCredentials = credencial,
                Expires = DateTime.UtcNow.AddHours(2)
            };
            //Geração do token e sua string para enviar
            var token = handler.CreateToken(tokenDescriptor);
            return handler.WriteToken(token);
        }
        private static ClaimsIdentity GeneretaClaims(Usuario user)
        {
            var ci = new ClaimsIdentity();
            ci.AddClaim(new Claim(ClaimTypes.Email, user.Email));
            ci.AddClaim(new Claim("Senha", user.Senha));
            return ci;
        }
    }
}