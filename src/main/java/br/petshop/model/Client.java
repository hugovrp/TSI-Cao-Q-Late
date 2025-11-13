package br.petshop.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Classe que representa um cliente do petshop.
 * Armazena informações pessoais do cliente e sua lista de cães.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class Client {
	private int id;
	private String cpf;
	private String name;
	private String email;
	private String telephone;
	private Date birth_date;
	private List<Dog> dog_list;
	
	/**
	 * Construtor padrão da classe Client.
	 * Inicializa a lista de cães como uma ArrayList vazia.
	 */
	public Client() {
		this.dog_list = new ArrayList<Dog>();
	}

	/**
	 * Obtém o ID único do cliente.
	 * 
	 * @return int contendo o identificador do cliente
	 */
	public int getId() {
		return id;
	}
	
	/**
	 * Obtém o CPF do cliente.
	 * 
	 * @return String contendo o CPF do cliente
	 */
	public String getCpf() {
		return cpf;
	}
	
	/**
	 * Obtém o nome completo do cliente.
	 * 
	 * @return String contendo o nome do cliente
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * Obtém o endereço de e-mail do cliente.
	 * 
	 * @return String contendo o e-mail do cliente
	 */
	public String getEmail() {
		return email;
	}
	
	/**
	 * Obtém o número de telefone do cliente.
	 * 
	 * @return String contendo o telefone do cliente
	 */
	public String getTelephone() {
		return telephone;
	}
	
	/**
	 * Obtém a data de nascimento do cliente.
	 * 
	 * @return Date contendo a data de nascimento do cliente
	 */
	public Date getBirthDate() {
		return birth_date;
	}
	
	/**
	 * Obtém a lista de cães pertencentes ao cliente.
	 * 
	 * @return List<Dog> contendo todos os cães do cliente
	 */
	public List<Dog> getDogList() {
		return dog_list;
	}
	
	/**
	 * Define o ID único do cliente.
	 * 
	 * @param id int contendo o novo identificador do cliente
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Define o CPF do cliente.
	 * 
	 * @param cpf String contendo o novo CPF do cliente
	 */
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	
	/**
	 * Define o nome completo do cliente.
	 * 
	 * @param name String contendo o novo nome do cliente
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * Define o endereço de e-mail do cliente.
	 * 
	 * @param email String contendo o novo e-mail do cliente
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	
	/**
	 * Define o número de telefone do cliente.
	 * 
	 * @param telephone String contendo o novo telefone do cliente
	 */
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	/**
	 * Define a data de nascimento do cliente.
	 * 
	 * @param birth_date Date contendo a nova data de nascimento
	 */
	public void setBirthDate(Date birth_date) {
		this.birth_date = birth_date;
	}
	
	/**
	 * Define a lista completa de cães do cliente.
	 * 
	 * @param dog_list List<Dog> contendo a nova lista de cães
	 */
	public void setDogList(List<Dog> dog_list) {
		this.dog_list = dog_list;
	}
}
