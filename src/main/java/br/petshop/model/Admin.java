package br.petshop.model;

/**
 * Classe que representa um administrador do sistema petshop.
 * Responsável por armazenar as credenciais de acesso do administrador.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class Admin {
	private String login;
	private String password;
	
	/**
	 * Obtém o login do administrador.
	 * 
	 * @return String contendo o login do administrador
	 */
	public String getLogin() {
		return login;
	}
	
	/**
	 * Obtém a senha do administrador.
	 * 
	 * @return String contendo a senha do administrador
	 */
	public String getPassword() {
		return password;
	}
	
	/**
	 * Define o login do administrador.
	 * 
	 * @param login String contendo o novo login do administrador
	 */
	public void setLogin(String login) {
		this.login = login;
	}
	
	/**
	 * Define a senha do administrador.
	 * 
	 * @param password String contendo a nova senha do administrador
	 */
	public void setPassword(String password) {
		this.password = password;
	}
}