package br.petshop.controller.handler.actions;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.SchedulingDAO;
import br.petshop.model.Scheduling;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável por exibir a lista de agendamentos.
 * 
 * Lista todos os agendamentos a partir da data atual (hoje), permitindo visualizar os próximos compromissos agendados.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ShowListScheduling implements Handler {

	/**
	 * Carrega a lista de agendamentos a partir da data atual.
	 * 
	 * @param request Requisição HTTP
	 * @param response Objeto de resposta HTTP
	 * @return Caminho da página de listagem (scheduling_list.jsp)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
    @Override
    public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Obtém a data atual do sistema
        Date today = new Date(System.currentTimeMillis());

        // Busca os agendamentos a partir de hoje
        SchedulingDAO dao = new SchedulingDAO();
        List<Scheduling> schedulings = dao.scheduling_list(today);

        // Disponibiliza os dados para a página JSP
        request.setAttribute("schedulings", schedulings);
        request.setAttribute("startDate", today.toString());

        return "scheduling_list.jsp";
    }
}