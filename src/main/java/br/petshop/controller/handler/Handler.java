package br.petshop.controller.handler;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Interface base para todos os handlers (ações) da aplicação.
 * 
 * Esta interface define o contrato que todas as classes de ação devem seguir. 
 * Cada handler representa uma operação específica do sistema (cadastrar cliente, agendar serviço, etc.).
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public interface Handler {
	
	/**
	 * Executa a lógica de negócio específica do handler.
	 * 
	 * @param request Objeto contendo os dados da requisição HTTP
	 * @param response Objeto para manipular a resposta HTTP
	 * @return String com o caminho relativo da página JSP de destino
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
	public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}