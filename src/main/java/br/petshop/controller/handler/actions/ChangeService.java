package br.petshop.controller.handler.actions;

import java.io.IOException;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.ServiceDAO;
import br.petshop.model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável pela atualização dos dados de um serviço existente.
 * 
 * Permite ao administrador modificar o preço de um serviço já cadastrado no sistema.
 * 
 * Parâmetros esperados na requisição:
 * - id: Identificador do serviço a ser alterado
 * - name: Nome do serviço
 * - price: Novo preço do serviço
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ChangeService implements Handler {

	/**
	 * Processa a atualização dos dados do serviço.
	 * 
	 * @param request Requisição contendo os novos dados do serviço
	 * @param response Objeto de resposta HTTP
	 * @return Caminho da página inicial de serviços (service_home.jsp)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
	@Override
	public String service(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		// Extrai os parâmetros do formulário de edição
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		
		// Cria objeto Service com os dados atualizados
		Service service = new Service();
		service.setId(Integer.parseInt(id));
		service.setName(name);
		service.setPrice(Float.parseFloat(price));
		
		// Atualiza o serviço no banco de dados
		ServiceDAO dao = new ServiceDAO();
		dao.change_price(service);
		
		return "service_home.jsp";
	}
}