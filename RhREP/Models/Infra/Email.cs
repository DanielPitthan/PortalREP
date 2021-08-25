using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace Models.Infra
{
    public class Email
    {       
      
        public string To { get; set; }
        public string CC { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }
        public NetworkCredential Credentials { get; set; }
        public Attachment[] Anexos { get; set; }

    }
}
