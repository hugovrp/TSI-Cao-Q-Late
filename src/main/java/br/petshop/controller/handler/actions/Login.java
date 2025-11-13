package br.petshop.controller.handler.actions;

import java.io.IOException;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.AdminDAO;
import br.petshop.model.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Handler responsável pela autenticação de usuários.
 * 
 * Valida as credenciais do administrador e cria uma sessão em caso de sucesso.
 * 
 * Parâmetros esperados na requisição:
 * - login: Nome de usuário
 * - hashedPassword: Senha hash do usuário
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class Login implements Handler {
    
    /**
     * Processa a autenticação do usuário.
     * 
     * Valida as credenciais e, em caso de sucesso, cria uma sessão com timeout de 2 minutos.
     * Em caso de falha, redireciona com parâmetro de erro.
     * 
     * @param request Requisição contendo credenciais de login
     * @param response Objeto de resposta HTTP
     * @return Caminho da página inicial (index.jsp) em caso de sucesso ou página de login com erro
     * @throws ServletException Se houver erro no processamento
     * @throws IOException Se houver erro de entrada/saída
     */
    @Override
    public String service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String login = request.getParameter("login");
        String passwordHash = request.getParameter("hashedPassword");
        
        // Se não receber o hash (requisição direta sem JS), redireciona para login
        if (passwordHash == null || passwordHash.trim().isEmpty()) {
            return "login.jsp?error=invalid";
        }
        
        String url = "login.jsp";
        AdminDAO adminDao = new AdminDAO();
        Admin admin = adminDao.validate_credentials(login, passwordHash);
        
        if(admin != null) {
            HttpSession session = request.getSession();
            
            // Sessão expira em 2 minutos
            session.setMaxInactiveInterval(2 * 60);
            session.setAttribute("status", true);
            session.setAttribute("name", login);
            session.setAttribute("loginTime", System.currentTimeMillis());
            
            url = "index.jsp";
        } else {
            // Redireciona com parâmetro de erro
            url = "login.jsp?error=invalid";
        }
        return url;
    }
}