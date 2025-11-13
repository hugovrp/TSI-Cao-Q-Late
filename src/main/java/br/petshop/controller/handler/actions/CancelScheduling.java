package br.petshop.controller.handler.actions;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.SchedulingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável pelo cancelamento de agendamentos.
 * 
 * Implementa regra de negócio que permite cancelamento apenas com antecedência mínima de 24 horas (mais de 1 dia).
 * 
 * Parâmetros esperados na requisição:
 * - id: ID do agendamento a ser cancelado
 * - date: Data do agendamento (para validação)
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class CancelScheduling implements Handler {
	
	/**
	 * Processa o cancelamento de um agendamento.
	 * 
	 * Valida se o cancelamento está sendo feito com antecedência mínima de 24 horas antes de executar a operação.
	 * 
	 * @param request Requisição contendo ID e data do agendamento
	 * @param response Objeto de resposta HTTP
	 * @return Caminho da página de listagem (scheduling_list.jsp)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
    @Override
    public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Extrai os parâmetros da requisição
        int id = Integer.parseInt(request.getParameter("id"));
        Date date = Date.valueOf(request.getParameter("date"));
        LocalDate today = LocalDate.now();

        // Validação: permite cancelar apenas com mais de 24h de antecedência
        if(date.toLocalDate().isAfter(today.plusDays(1))) {
            SchedulingDAO dao = new SchedulingDAO();
            dao.cancel_scheduling(id);
            request.setAttribute("message", "Agendamento cancelado com sucesso!");
        } else {
            // Cancelamento negado - menos de 24h de antecedência
            request.setAttribute("error", "Não é possível cancelar com menos de 24h de antecedência.");
        }

        return "scheduling_list.jsp";
    }
}