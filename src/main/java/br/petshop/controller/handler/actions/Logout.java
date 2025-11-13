package br.petshop.controller.handler.actions;

import java.io.IOException;

import br.petshop.controller.handler.Handler;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Handler responsável pelo logout de usuários.
 * 
 * Invalida a sessão atual do usuário, realizando o logout do sistema.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class Logout implements Handler {

    /**
     * Processa o logout do usuário.
     * 
     * Invalida a sessão atual e redireciona para a página de login.
     * 
     * @param request Requisição HTTP
     * @param response Objeto de resposta HTTP
     * @return Caminho da página de login (login.jsp)
     * @throws ServletException Se houver erro no processamento
     * @throws IOException Se houver erro de entrada/saída
     */
	@Override
	public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		session.invalidate();
		return "login.jsp";
	}
}