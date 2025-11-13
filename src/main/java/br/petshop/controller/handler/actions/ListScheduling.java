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
 * Handler responsável por listar agendamentos a partir de uma data específica.
 * 
 * Permite filtrar os agendamentos por data de início. Se nenhuma data for informada, utiliza a data atual como padrão.
 * 
 * Parâmetros esperados na requisição:
 * - start_date: Data inicial para filtro (opcional, formato: yyyy-MM-dd)
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ListScheduling implements Handler {
	
	/**
	 * Lista os agendamentos a partir de uma data específica ou atual.
	 * 
	 * @param request Requisição HTTP (pode conter o parâmetro start_date)
	 * @param response Objeto de resposta HTTP
	 * @return Caminho da página de listagem (scheduling_list.jsp)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
    @Override
    public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Obtém o parâmetro de data, se fornecido
        String dateParam = request.getParameter("start_date");
        
        // Define a data de início: parâmetro ou data atual
        Date startDate = (dateParam != null && !dateParam.isEmpty()) 
        		? Date.valueOf(dateParam) 
        		: new Date(System.currentTimeMillis());

        // Busca os agendamentos a partir da data definida
        SchedulingDAO dao = new SchedulingDAO();
        List<Scheduling> schedulings = dao.scheduling_list(startDate);

        // Disponibiliza a lista para a página JSP
        request.setAttribute("schedulings", schedulings);
        
        return "scheduling_list.jsp";
    }
}