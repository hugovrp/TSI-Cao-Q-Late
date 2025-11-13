package br.petshop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.petshop.database.ConnectionFactory;
import br.petshop.model.Service;

/**
 * Classe de acesso a dados (DAO) para a entidade Service.
 * Responsável por todas as operações de banco de dados relacionadas aos serviços oferecidos pelo petshop.
 * 
 * Esta classe gerencia o cadastro, busca, atualização de preços e listagem de serviços disponíveis.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ServiceDAO {
	private Connection connection;
	
	/**
	 * Construtor padrão que inicializa a conexão com o banco de dados.
	 * Obtém uma conexão através da ConnectionFactory.
	 */
	public ServiceDAO() {
		this.connection = ConnectionFactory.getConnection();
	}
	
	/**
	 * Registra um novo serviço no banco de dados.
	 * 
	 * @param service objeto Service contendo nome e preço do serviço a ser cadastrado
	 * @return boolean true se o registro foi bem-sucedido, false caso contrário
	 */
	public boolean register_service(Service service) {
		String cmd_sql = "insert into service (name, price) values (?,?)";
		
		try(PreparedStatement statement = connection.prepareCall(cmd_sql)) {
			statement.setString(1, service.getName());
			statement.setFloat(2, service.getPrice());
			statement.execute();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/**
	 * Busca um serviço específico no banco de dados pelo seu ID.
	 * 
	 * @param service objeto Service contendo o ID do serviço a ser buscado
	 * @return Service objeto contendo todos os dados do serviço encontrado
	 */
	public Service get_service(Service service) {
		String cmd_sql = "select * from service where id=?";
		Service s = new Service();
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			statement.setInt(1, service.getId());
			ResultSet result = statement.executeQuery();
			
			while(result.next()) {
				s.setId(result.getInt("id"));
				s.setName(result.getString("name"));
				s.setPrice(result.getFloat("price"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return s;
	}
	
	/**
	 * Atualiza o preço de um serviço existente.
	 * 
	 * Permite ajustar os valores dos serviços conforme necessário, mantendo o ID e nome do serviço inalterados.
	 * 
	 * @param service objeto Service contendo o ID e o novo preço a ser atualizado
	 */
	public void change_price(Service service) {
		String cmd_sql = "update service set price=? where id=?";
		
		try(PreparedStatement statement = connection.prepareCall(cmd_sql)) {
			statement.setFloat(1, service.getPrice());
			statement.setInt(2, service.getId()); 
			statement.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Lista todos os serviços cadastrados no sistema.
	 * 
	 * @return List<Service> lista contendo todos os serviços disponíveis, lista vazia se nenhum encontrado
	 */
	public List<Service> service_list(){
		List<Service> services = new ArrayList<Service>();
		String cmd_sql = "select * from service";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			ResultSet result = statement.executeQuery();
			while(result.next()) {
				Service service = new Service();
				service.setId(result.getInt("id"));
				service.setName(result.getString("name"));
				service.setPrice(result.getFloat("price"));
				
				services.add(service);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return services;
	}
}