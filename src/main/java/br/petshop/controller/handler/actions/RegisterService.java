package br.petshop.controller.handler.actions;

import java.io.IOException;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.ServiceDAO;
import br.petshop.model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável pelo cadastro de novos serviços no sistema.
 * 
 * Recebe os dados do formulário de cadastro de serviços (nome e preço), cria um objeto Service 
 * e o persiste no banco de dados através do ServiceDAO.
 * 
 * Parâmetros esperados na requisição:
 * - name: Nome do serviço (ex: "Banho", "Tosa")
 * - price: Preço do serviço em formato numérico (ex: "50.00")
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class RegisterService implements Handler {

	/**
	 * Processa o cadastro de um novo serviço.
	 * 
	 * @param request Requisição contendo os parâmetros do serviço
	 * @param response Objeto de resposta HTTP
	 * @return Caminho da página JSP de destino (service_home.jsp)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
	@Override
	public String service(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		// Extrai os parâmetros do formulário
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		
		// Cria o objeto Service
		Service service = new Service();
		service.setName(name);
		service.setPrice(Float.parseFloat(price));
		
		// Persiste o serviço no banco de dados
		ServiceDAO dao = new ServiceDAO();
		dao.register_service(service);
		
		// Adiciona o serviço cadastrado como atributo para exibição na página
		request.setAttribute("service", service);
		
		return "service_home.jsp";
	}
}