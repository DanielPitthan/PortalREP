using Microsoft.IdentityModel.Protocols;
using Models.Infra;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace RHRep.Infra
{
    internal class EmailHelper
    {
        private Email email = new Email();
        private string mailFrom = "workflow@exceptionbrasil.com.br";
        private string host = "mail.exceptionbrasil.com.br";
        private string SenhaEmail = "Workflow@123";
        private int hostPort = 587;
        private string cCEmail = "dps@exceptionbrasil.com.br";


        public EmailHelper(Email _email)
        {
            email.Body = _email.Body;
            email.Subject = _email.Subject;
            email.To = _email.To;
            email.Credentials = new NetworkCredential(mailFrom, SenhaEmail);
            email.Anexos = _email.Anexos;
        }

        public void Send()
        {
            using (MailMessage message = new MailMessage())
            {
                using (SmtpClient smtp = new SmtpClient())
                {
                    message.From = new MailAddress(mailFrom);
                    message.To.Add(new MailAddress(email.To));
                    message.Subject = email.Subject;
                    message.IsBodyHtml = true;
                    message.Body = email.Body;

                    if (email.Anexos != null)
                    {
                        for (int i = 0; i < email.Anexos.Length; i++)
                        {
                            message.Attachments.Add(email.Anexos[i]);
                        }
                    }

                    if (!string.IsNullOrEmpty(cCEmail))
                    {
                        message.CC.Add(cCEmail);
                    }

                    smtp.Port = hostPort;
                    smtp.Host = host;
                    smtp.EnableSsl = true;

                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = email.Credentials;
                    smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                    try
                    {
                        smtp.Send(message);
                    }
                    catch (SmtpException ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                }
            }

        }

        
    }
}
