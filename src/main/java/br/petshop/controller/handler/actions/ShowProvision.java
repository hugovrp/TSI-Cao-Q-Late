package br.petshop.controller.handler.actions;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.ServiceProvisionDAO;
import br.petshop.model.ServiceProvision;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável pela exibição do relatório de prestações de serviço.
 * 
 * Permite filtrar as prestações por período de datas e calcular o faturamento total.
 * 
 * Parâmetros esperados na requisição:
 * - start_date: Data inicial do período (formato yyyy-MM-dd)
 * - end_date: Data final do período (formato yyyy-MM-dd)
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ShowProvision implements Handler {

    /**
     * Processa a exibição do relatório de prestações de serviço.
     * 
     * Se não receber datas, exibe o formulário de filtro. Caso contrário,
     * busca as prestações no período especificado e calcula o faturamento total.
     * 
     * @param request Requisição contendo parâmetros de data
     * @param response Objeto de resposta HTTP
     * @return Caminho da página de relatório (service_provision_report.jsp)
     * @throws ServletException Se houver erro no processamento
     * @throws IOException Se houver erro de entrada/saída
     */
    @Override
    public String service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String start_date_str = request.getParameter("start_date");
        String end_date_str = request.getParameter("end_date");
        
        // Se não tem datas, mostra o formulário
        if (start_date_str == null || end_date_str == null || 
            start_date_str.isEmpty() || end_date_str.isEmpty()) {
            return "service_provision_report.jsp";
        }
        
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date util_start_date = sdf.parse(start_date_str);
            java.util.Date util_end_date = sdf.parse(end_date_str);
            
            Date start_date = new Date(util_start_date.getTime());
            Date end_date = new Date(util_end_date.getTime());
            
            ServiceProvisionDAO provision_dao = new ServiceProvisionDAO();
            List<ServiceProvision> provisions = provision_dao.provision_report(start_date, end_date);
            float total_revenue = provision_dao.calculate_total_revenue(start_date, end_date);
            
            request.setAttribute("provisions", provisions);
            request.setAttribute("total_revenue", total_revenue);
            request.setAttribute("start_date", start_date_str);
            request.setAttribute("end_date", end_date_str);
            
            return "service_provision_report.jsp";
            
        } catch (ParseException e) {
            request.setAttribute("error", "Formato de data inválido. Use o formato AAAA-MM-DD");
            return "service_provision_report.jsp";
        }
    }
}