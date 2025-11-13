package br.petshop.controller.handler.actions;

import java.io.IOException;
import java.sql.Date;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.SchedulingDAO;
import br.petshop.dao.ServiceProvisionDAO;
import br.petshop.model.ServiceProvision;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável pelo registro de prestações de serviço.
 * 
 * Permite registrar a prestação de serviço baseada em agendamentos existentes.
 * 
 * Parâmetros esperados na requisição:
 * - action: Ação a ser executada ("register" para registrar)
 * - scheduling_id: ID do agendamento a ser convertido em prestação
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class RegisterProvision implements Handler {

    /**
     * Processa o registro de prestação de serviço.
     * 
     * Se não receber ação, exibe o formulário com agendamentos disponíveis.
     * Se receber ação "register", converte o agendamento em prestação de serviço.
     * 
     * @param request Requisição contendo parâmetros de ação e ID do agendamento
     * @param response Objeto de resposta HTTP
     * @return Caminho da página de registro (service_provision_register.jsp)
     * @throws ServletException Se houver erro no processamento
     * @throws IOException Se houver erro de entrada/saída
     */
    @Override
    public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // Se não tem action, mostra o formulário
        if (action == null || action.isEmpty()) {
            // Carrega os agendamentos disponíveis para seleção
            SchedulingDAO scheduling_dao = new SchedulingDAO();
            Date today = new Date(System.currentTimeMillis());
            
            request.setAttribute("schedulings", scheduling_dao.scheduling_list(today));
            return "service_provision_register.jsp";
        }
        
        // Processa o lançamento da prestação
        if ("register".equals(action)) {
            String scheduling_id_str = request.getParameter("scheduling_id");
            
            if (scheduling_id_str == null || scheduling_id_str.isEmpty()) {
                request.setAttribute("error", "Selecione um agendamento válido");
                return "service_provision_register.jsp";
            }
            
            try {
                int scheduling_id = Integer.parseInt(scheduling_id_str);
                
                ServiceProvisionDAO provision_dao = new ServiceProvisionDAO();
                ServiceProvision provision = provision_dao.register_provision(scheduling_id);
                
                if (provision != null) {
                    request.setAttribute("success", "Prestação de serviço registrada com sucesso!");
                    request.setAttribute("provision", provision);
                    return "service_provision_register.jsp";
                } else {
                    request.setAttribute("error", "Erro ao registrar prestação. " +
                            "Verifique se o agendamento está com status 'Agendado'.");
                    return "service_provision_register.jsp";
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID de agendamento inválido");
                return "service_provision_register.jsp";
            }
        }
        
        return "service_provision_register.jsp";
    }
}