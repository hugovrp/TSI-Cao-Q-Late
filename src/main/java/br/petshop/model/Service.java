package br.petshop.model;

/**
 * Classe que representa um serviço oferecido pelo petshop.
 * Armazena informações sobre o tipo de serviço e seu preço base.
 * Exemplos: banho, tosa, vacinação, consulta veterinária, etc.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class Service {
	private int id;
	private String name;
	private float price;
	
	/**
	 * Obtém o ID único do serviço.
	 * 
	 * @return int contendo o identificador do serviço
	 */
	public int getId() {
		return id;
	}
	
	/**
	 * Obtém o nome do serviço.
	 * 
	 * @return String contendo o nome do serviço (ex: "Banho", "Tosa", "Vacinação")
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * Obtém o preço base do serviço.
	 * 
	 * @return float contendo o valor do serviço em reais
	 */
	public float getPrice() {
		return price;
	}
	
	/**
	 * Define o ID único do serviço.
	 * 
	 * @param id int contendo o novo identificador do serviço
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * Define o nome do serviço.
	 * 
	 * @param name String contendo o novo nome do serviço
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * Define o preço base do serviço.
	 * 
	 * @param price float contendo o novo valor do serviço em reais
	 */
	public void setPrice(float price) {
		this.price = price;
	}
}
