using Microsoft.EntityFrameworkCore;
using RHRep.BLL.Tickets.Interfaces;
using RHRep.Core.Tickets.Interfaces;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RHRep.BLL.Tickets.Services
{
    public class ImagensTicketsService : IImagensTicketService
    {
        private readonly IImagensTicktsDAO imagensDAO;

        public ImagensTicketsService(IImagensTicktsDAO _imagensDAO)
        {
            this.imagensDAO = _imagensDAO;
        }

        public async Task<bool> Excluir(IList<ImagensTickets> imagem)
        {
            foreach (var item in imagem)
            {
                await this.imagensDAO.DeleteAsync(item);
            }
            return true;
        }

        public async Task<bool> Incluir(IList<ImagensTickets> imagem)
        {
            foreach (var item in imagem)
            {
                if (item.Id == 0)
                    await this.imagensDAO.AddSysnc(item);
                else
                    await this.imagensDAO.UpdateAsync(item);
            }
            return true;
        }

        public async Task<IList<ImagensTickets>> ListarImagensTicket(string ticket)
        {
            var imagens = await this.imagensDAO.All()
                                .Where(x => x.ZC0_NUM == ticket)
                                .ToListAsync();
            return imagens;

        }

        public async Task<bool> SetWorkflowId(string ticket, int workflowId)
        {
            var anexos = await this.ListarImagensTicket(ticket);
            Parallel.ForEach(anexos, (anexo) =>
            {
                anexo.WorkflowId = workflowId;
            });
            foreach (var anexo in anexos)
            {
                await this.imagensDAO.UpdateAsync(anexo);
            }
            return true;
        }
    }
}
