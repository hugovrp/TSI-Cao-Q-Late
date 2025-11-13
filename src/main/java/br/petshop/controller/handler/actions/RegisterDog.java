package br.petshop.controller.handler.actions;

import java.io.IOException;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.ClientDAO;
import br.petshop.dao.DogDAO;
import br.petshop.model.Client;
import br.petshop.model.Dog;
import br.petshop.model.Dog.DogSize;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável pelo cadastro de cães no sistema.
 * 
 * Vincula o cão a um cliente existente (dono) e valida se o porte informado é válido (SMALL, MEDIUM ou LARGE).
 * 
 * Parâmetros esperados na requisição:
 * - name: Nome do cão
 * - breed: Raça do cão
 * - size: Porte do cão (SMALL, MEDIUM ou LARGE)
 * - owner_id: ID do cliente dono do cão
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class RegisterDog implements Handler {

	/**
	 * Processa o cadastro de um novo cão.
	 * 
	 * Valida se o porte é válido e se o cliente dono existe no sistema antes de realizar o cadastro.
	 * 
	 * @param request Requisição contendo os dados do cão
	 * @param response Objeto de resposta HTTP
	 * @return Caminho da página (dog_home.jsp ou dog_register.jsp em caso de erro)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
	@Override
	public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Extrai os parâmetros do formulário
		String name = request.getParameter("name");
		String breed = request.getParameter("breed");
		String size_request = request.getParameter("size");
		String owner_id = request.getParameter("owner_id");
		
		// Converte a String do porte para o enum DogSize
		DogSize size;
        switch (size_request.toUpperCase()) {
            case "SMALL":
                size = DogSize.SMALL;
                break;
            case "MEDIUM":
                size = DogSize.MEDIUM;
                break;
            case "LARGE":
                size = DogSize.LARGE;
                break;
            default:
                // Porte inválido - retorna para o formulário com mensagem de erro
                request.setAttribute("error", "Porte inválido selecionado");
                return "dog_register.jsp";
        }
		
        // Cria e popula o objeto Dog
        Dog dog = new Dog();
        dog.setName(name);
        dog.setBreed(breed);
        dog.setSize(size);
        
        // Busca o cliente dono do cão
        int clientId = Integer.parseInt(owner_id);
        ClientDAO client_dao = new ClientDAO();
        Client client = client_dao.find_client(clientId);
        
        // Valida se o cliente existe
        if (client == null) {
             request.setAttribute("error", "Cliente não encontrado");
             return "dog_register.jsp";
        }
        dog.setOwner(client);

        // Persiste o cão no banco de dados
        DogDAO dao = new DogDAO();
        dao.register_dog(dog);
		
		return "dog_home.jsp";
	}
}