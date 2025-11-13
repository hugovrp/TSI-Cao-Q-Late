package br.petshop.controller.handler.actions;

import java.io.IOException;
import java.util.List;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.ServiceDAO;
import br.petshop.model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável por preparar a página de cadastro de agendamentos.
 * 
 * Carrega a lista de todos os serviços disponíveis para que o usuário possa selecioná-los ao criar um novo agendamento.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ShowScheduling implements Handler {

	/**
	 * Carrega os serviços disponíveis para exibição no formulário de agendamento.
	 * 
	 * @param request Requisição HTTP
	 * @param response Objeto de resposta HTTP
	 * @return Caminho do formulário de agendamento (scheduling_register.jsp)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
	@Override
	public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Busca todos os serviços cadastrados no banco de dados
		ServiceDAO dao = new ServiceDAO();
		List<Service> services = dao.service_list();

		// Disponibiliza a lista de serviços para o JSP
		request.setAttribute("services", services);

		// Encaminha para o formulário de agendamento
		return "scheduling_register.jsp";
	}
}