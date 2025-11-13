package br.petshop.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Classe que representa um agendamento de serviços no petshop.
 * Registra a marcação de um ou mais serviços para um cão específico
 * em uma determinada data, vinculando cliente, cão e serviços.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class Scheduling {
	private int id;
	private String status;
	private Client client;
	private Dog dog;
	private Date date;
	private List<Service> services_list;
	
	/**
	 * Construtor padrão da classe Scheduling.
	 * Inicializa a lista de serviços como uma ArrayList vazia.
	 */
	public Scheduling() {
		this.services_list = new ArrayList<Service>();
	}

	/**
	 * Obtém o ID único do agendamento.
	 * 
	 * @return int contendo o identificador do agendamento
	 */
	public int getId() {
		return id;
	}

	/**
	 * Obtém o status atual do agendamento.
	 * 
	 * @return String contendo o status (ex: "Pendente", "Confirmado", "Cancelado", "Concluído")
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * Obtém o cliente responsável pelo agendamento.
	 * 
	 * @return Client contendo as informações do cliente
	 */
	public Client getClient() {
		return client;
	}

	/**
	 * Obtém o cão para o qual os serviços foram agendados.
	 * 
	 * @return Dog contendo as informações do cão
	 */
	public Dog getDog() {
		return dog;
	}

	/**
	 * Obtém a data do agendamento.
	 * 
	 * @return Date contendo a data e hora marcadas para os serviços
	 */
	public Date getDate() {
		return date;
	}

	/**
	 * Obtém a lista de serviços incluídos neste agendamento.
	 * 
	 * @return List<Service> contendo todos os serviços agendados
	 */
	public List<Service> getServicesList() {
		return services_list;
	}

	/**
	 * Define o ID único do agendamento.
	 * 
	 * @param id int contendo o novo identificador do agendamento
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * Define o status do agendamento.
	 * 
	 * @param status String contendo o novo status do agendamento
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * Define o cliente responsável pelo agendamento.
	 * 
	 * @param client Client contendo as informações do cliente
	 */
	public void setClient(Client client) {
		this.client = client;
	}

	/**
	 * Define o cão que receberá os serviços.
	 * 
	 * @param dog Dog contendo as informações do cão
	 */
	public void setDog(Dog dog) {
		this.dog = dog;
	}

	/**
	 * Define a data do agendamento.
	 * 
	 * @param date Date contendo a nova data e hora do agendamento
	 */
	public void setDate(Date date) {
		this.date = date;
	}

	/**
	 * Define a lista completa de serviços do agendamento.
	 * 
	 * @param services_list List<Service> contendo os serviços a serem realizados
	 */
	public void setServicesList(List<Service> services_list) {
		this.services_list = services_list;
	}
}
