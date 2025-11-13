package br.petshop.controller.handler.actions;

import java.io.IOException;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.ServiceDAO;
import br.petshop.model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável pela busca de um serviço específico por ID.
 * 
 * Utilizado quando o administrador deseja visualizar ou editar os dados de um serviço existente.
 * 
 * Parâmetros esperados na requisição:
 * - id: Identificador único do serviço
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class SearchService implements Handler {
	
	/**
	 * Busca um serviço no banco de dados pelo seu ID.
	 * 
	 * @param request Requisição contendo o ID do serviço
	 * @param response Objeto de resposta HTTP
	 * @return Caminho da página de edição (service_change.jsp)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
	@Override
	public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Obtém o ID do serviço a ser buscado
		String id = request.getParameter("id");
		
		// Cria objeto Service com o ID para busca
		Service service = new Service();
		service.setId(Integer.parseInt(id));
		
		// Busca o serviço completo no banco de dados
		ServiceDAO dao = new ServiceDAO();
		Service new_service = dao.get_service(service);
		
		// Adiciona o serviço encontrado como atributo para a página de edição
		request.setAttribute("service", new_service);
		
		return "service_change.jsp";
	}
}