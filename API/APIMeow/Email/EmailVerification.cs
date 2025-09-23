using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http.HttpResults;

namespace APIMeow.Email
{
    public class EmailVerification : IEmailVerification
    {
        public int _codeVerify { get; private set; }
        public DateTime _codeExpire { get; private set; }
        private const int CodeExpireMinutes = 10;

        public string Email { get; private set; }
        public string Nome { get; private set; }

        public EmailVerification()
        {
        }

        public EmailVerification(string usuario, string nome)
        {
            Email = usuario;
            Nome = nome;
            _codeVerify = new Random().Next(100000, 999999);
            _codeExpire = DateTime.Now.AddMinutes(CodeExpireMinutes);
        }

        public async Task<bool> SendEmail()
        {
            try
            {
                string destinatario = Email;
                string remetente = "gurtgigachaduni.zazu@gmail.com";
                MailMessage msg = new MailMessage(remetente, destinatario);
                msg.Subject = "Código de Verificação de Email - Meownagement";
                msg.Body = $"Olá {Nome},\n\nSeu código de verificação é: {_codeVerify}\n\nEste código é válido por {CodeExpireMinutes} minutos.\n\nSe você não solicitou este código, por favor ignore este email.\n\nAtenciosamente,\nEquipe Meownagement 🐈‍⬛";
                SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
                client.EnableSsl = true;
                client.Credentials = new System.Net.NetworkCredential(remetente, Environment.GetEnvironmentVariable("Senha"));
                await client.SendMailAsync(msg);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao enviar email: " + ex.Message);
            }
        }

//se alguem quiser testar
        public async void Spam()
        {
            while (true)
            {
                string destinatario = "cc24157@g.unicamp.br";
                string remetente = "gurtgigachaduni.zazu@gmail.com";
                MailMessage msg = new MailMessage(remetente, destinatario);
                msg.Subject = "Código de Verificação de Email - Meownagement";
                msg.Body = $"Olá {Nome},\n\nSeu código de verificação é: {_codeVerify}\n\nEste código é válido por {CodeExpireMinutes} minutos.\n\nSe você não solicitou este código, por favor ignore este email.\n\nAtenciosamente,\nEquipe Meownagement 🐈‍⬛";
                SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
                client.EnableSsl = true;
                client.Credentials = new System.Net.NetworkCredential(remetente, Environment.GetEnvironmentVariable("Senha"));
                await client.SendMailAsync(msg);
            }
        }
    }
}