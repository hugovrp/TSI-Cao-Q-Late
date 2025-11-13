package br.petshop.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Classe que representa um cão cadastrado no petshop.
 * Armazena informações do cão, seu proprietário, histórico de serviços
 * e agendamentos futuros.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class Dog {
	/**
	 * Enumeração que define os tamanhos possíveis para um cão.
	 * Utilizada para classificação e precificação de serviços.
	 */
	public enum DogSize {
		/** Cães de porte pequeno */
		SMALL,
		/** Cães de porte médio */
		MEDIUM,
		/** Cães de porte grande */
		LARGE
	}
	
	private int id;
	private String name;
	private String breed;
	private DogSize size;
	private Client owner;
	private List<ServiceProvision> service_history;
	private List<Scheduling> scheduled_services;

	/**
	 * Construtor padrão da classe Dog.
	 * Inicializa as listas de histórico de serviços e agendamentos como ArrayLists vazias.
	 */
	public Dog() {
		this.service_history = new ArrayList<ServiceProvision>();
		this.scheduled_services = new ArrayList<Scheduling>();
	}
	
	/**
	 * Obtém o ID único do cão.
	 * 
	 * @return int contendo o identificador do cão
	 */
	public int getId() {
		return id;
	}

	/**
	 * Obtém o nome do cão.
	 * 
	 * @return String contendo o nome do cão
	 */
	public String getName() {
		return name;
	}

	/**
	 * Obtém a raça do cão.
	 * 
	 * @return String contendo a raça do cão
	 */
	public String getBreed() {
		return breed;
	}

	/**
	 * Obtém o porte/tamanho do cão.
	 * 
	 * @return DogSize enum indicando se o cão é pequeno, médio ou grande
	 */
	public DogSize getSize() {
		return size;
	}

	/**
	 * Obtém o proprietário (cliente) do cão.
	 * 
	 * @return Client contendo as informações do dono do cão
	 */
	public Client getOwner() {
		return owner;
	}

	/**
	 * Obtém o histórico completo de serviços já realizados no cão.
	 * 
	 * @return List<ServiceProvision> contendo todos os serviços prestados
	 */
	public List<ServiceProvision> getServiceHistory() {
		return service_history;
	}

	/**
	 * Obtém a lista de serviços agendados para o cão.
	 * 
	 * @return List<Scheduling> contendo todos os agendamentos futuros
	 */
	public List<Scheduling> getScheduledServices() {
		return scheduled_services;
	}

	/**
	 * Define o ID único do cão.
	 * 
	 * @param id int contendo o novo identificador do cão
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * Define o nome do cão.
	 * 
	 * @param name String contendo o novo nome do cão
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * Define a raça do cão.
	 * 
	 * @param breed String contendo a nova raça do cão
	 */
	public void setBreed(String breed) {
		this.breed = breed;
	}

	/**
	 * Define o porte/tamanho do cão.
	 * 
	 * @param size DogSize enum indicando se o cão é pequeno, médio ou grande
	 */
	public void setSize(DogSize size) {
		this.size = size;
	}

	/**
	 * Define o proprietário (cliente) do cão.
	 * 
	 * @param owner Client contendo as informações do novo dono
	 */
	public void setOwner(Client owner) {
		this.owner = owner;
	}

	/**
	 * Define o histórico completo de serviços do cão.
	 * 
	 * @param service_history List<ServiceProvision> contendo o novo histórico de serviços
	 */
	public void setServiceHistory(List<ServiceProvision> service_history) {
		this.service_history = service_history;
	}

	/**
	 * Define a lista de agendamentos futuros do cão.
	 * 
	 * @param scheduled_services List<Scheduling> contendo os novos agendamentos
	 */
	public void setScheduledServices(List<Scheduling> scheduled_services) {
		this.scheduled_services = scheduled_services;
	}
}
