package br.petshop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.petshop.database.ConnectionFactory;
import br.petshop.model.Client;
import br.petshop.model.Dog;

/**
 * Classe de acesso a dados (DAO) para a entidade Client.
 * Responsável por todas as operações de banco de dados relacionadas aos clientes do petshop.
 * 
 * Esta classe gerencia o cadastro, busca e listagem de clientes, além de integrar o cadastro 
 * de cães pertencentes aos clientes.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ClientDAO {
	private Connection connection;
	
	/**
	 * Construtor padrão que inicializa a conexão com o banco de dados.
	 * Obtém uma conexão através da ConnectionFactory.
	 */
	public ClientDAO() {
		this.connection = ConnectionFactory.getConnection();
	}
	
	/**
	 * Registra um novo cliente no banco de dados.
	 * 
	 * Se o cliente possuir cães na sua lista (dog_list), estes também serão cadastrados automaticamente 
	 * através do DogDAO. O ID gerado para o cliente é automaticamente atribuído ao objeto.
	 * 
	 * @param client objeto Client contendo todos os dados do cliente a ser cadastrado
	 * @return boolean true se o registro foi bem-sucedido, false caso contrário
	 */
	public boolean register_client(Client client) {
		String cmd_sql = "insert into client (cpf, name, email, telephone, birth_date) values (?,?,?,?,?)";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			statement.setString(1, client.getCpf());
			statement.setString(2, client.getName());
			statement.setString(3, client.getEmail());
			statement.setString(4, client.getTelephone());
			statement.setDate(5, client.getBirthDate());
			
			int rows = statement.executeUpdate();
			
			if(rows > 0) {
				try(ResultSet result = statement.getGeneratedKeys()) {
					if(result.next()) {
						int generated_id = result.getInt(1);
						client.setId(generated_id);
					}
				}
			}
			
			// Cadastra os cães do cliente, se houver
			if(client.getDogList() != null && !client.getDogList().isEmpty()) {
				DogDAO dog_dao = new DogDAO();
				List<Dog> dog_list = client.getDogList();
				
				for(Dog dog : dog_list) {
					dog.setOwner(client);
					dog_dao.register_dog(dog);
				}
			}
						
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	/**
	 * Busca um cliente específico no banco de dados pelo seu ID.
	 * 
	 * @param id int identificador único do cliente
	 * @return Client objeto contendo os dados do cliente encontrado, null se não encontrado
	 */
	public Client find_client(int id) {
		String cmd_sql = "select * from client where id=?";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			statement.setInt(1, id);
			ResultSet result = statement.executeQuery();
			if(result.next()) {
				Client client = new Client();
				
				client.setId(result.getInt("id"));
				client.setCpf(result.getString("cpf"));
				client.setName(result.getString("name"));
				client.setEmail(result.getString("email"));
				client.setTelephone(result.getString("telephone"));
				client.setBirthDate(result.getDate("birth_date"));
				return client;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * Lista todos os clientes cadastrados no sistema.
	 * 
	 * @return List<Client> lista contendo todos os clientes cadastrados, lista vazia se nenhum encontrado
	 */
	public List<Client> clients_list() {
		List<Client> clients = new ArrayList<Client>();
		String cmd_sql = "select * from client";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			ResultSet result = statement.executeQuery();
			while(result.next()) {
				Client client = new Client();
				
				client.setId(result.getInt("id"));
				client.setCpf(result.getString("cpf"));
				client.setName(result.getString("name"));
				client.setEmail(result.getString("email"));
				client.setTelephone(result.getString("telephone"));
				client.setBirthDate(result.getDate("birth_date"));
				
				clients.add(client);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return clients;
	}
}