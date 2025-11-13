package br.petshop.controller.handler.actions;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.ClientDAO;
import br.petshop.model.Client;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável pelo cadastro de novos clientes no sistema.
 * 
 * Recebe todos os dados pessoais do cliente através de um formulário, realiza a conversão de data de 
 * nascimento e persiste no banco de dados.
 * 
 * Parâmetros esperados na requisição:
 * - cpf: CPF do cliente (documento único)
 * - name: Nome completo do cliente
 * - email: Email do cliente
 * - telephone: Telefone de contato
 * - birth_date: Data de nascimento no formato dd/MM/yyyy
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class RegisterClient implements Handler {

	/**
	 * Processa o cadastro de um novo cliente.
	 * 
	 * Realiza a conversão da data de nascimento de String para java.sql.Date antes de persistir no banco de dados.
	 * 
	 * @param request Requisição contendo os dados do cliente
	 * @param response Objeto de resposta HTTP
	 * @return Caminho da página inicial de clientes (client_home.jsp)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
	@Override
	public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Extrai os parâmetros do formulário de cadastro
		String cpf = request.getParameter("cpf");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String telephone = request.getParameter("telephone");
		String birth_date = request.getParameter("birth_date");
		
		// Cria o objeto Client
		Client client = new Client();
		client.setCpf(cpf);
		client.setName(name);
		client.setEmail(email);
		client.setTelephone(telephone);
		
		// Converte a data de nascimento de String para Date
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date util_date = null;

		try {
		    util_date = format.parse(birth_date);
		} catch (ParseException e) {
		    e.printStackTrace();
		}
		
		// Converte java.util.Date para java.sql.Date
		java.sql.Date sql_date = new java.sql.Date(util_date.getTime());
		client.setBirthDate(sql_date);
		
		// Persiste o cliente no banco de dados
		ClientDAO dao = new ClientDAO();
		dao.register_client(client);
		
		// Adiciona o cliente cadastrado como atributo
		request.setAttribute("client", client);
		
		return "client_home.jsp";
	}
}