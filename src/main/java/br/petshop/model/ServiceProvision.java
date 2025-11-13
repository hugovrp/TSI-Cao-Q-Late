package br.petshop.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Classe que representa a prestação efetiva de serviços no petshop.
 * Registra os serviços que foram concretamente realizados, incluindo
 * informações sobre valores cobrados, descontos aplicados e a data de execução.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ServiceProvision {
	private int id;
	private boolean discount;
	private float amount_charged;
	private Date date;
	private Dog dog;
	private Scheduling scheduling;
	private List<Service> services_list;
	
	/**
	 * Construtor padrão da classe ServiceProvision.
	 * Inicializa a lista de serviços como uma ArrayList vazia.
	 */
	public ServiceProvision() {
		this.services_list = new ArrayList<Service>();
	}

	/**
	 * Obtém o ID único do registro de prestação de serviço.
	 * 
	 * @return int contendo o identificador da prestação de serviço
	 */
	public int getId() {
		return id;
	}

	/**
	 * Verifica se foi aplicado desconto nesta prestação de serviço.
	 * 
	 * @return boolean true se houve desconto, false caso contrário
	 */
	public boolean isDiscount() {
		return discount;
	}

	/**
	 * Obtém o valor total cobrado pelos serviços prestados.
	 * Este valor já considera possíveis descontos aplicados.
	 * 
	 * @return float contendo o valor final cobrado em reais
	 */
	public float getAmountCharged() {
		return amount_charged;
	}

	/**
	 * Obtém a data em que os serviços foram efetivamente realizados.
	 * 
	 * @return Date contendo a data de execução dos serviços
	 */
	public Date getDate() {
		return date;
	}

	/**
	 * Obtém o cão que recebeu os serviços.
	 * 
	 * @return Dog contendo as informações do cão atendido
	 */
	public Dog getDog() {
		return dog;
	}

	/**
	 * Obtém o agendamento original que gerou esta prestação de serviço.
	 * Permite rastrear a origem do atendimento.
	 * 
	 * @return Scheduling contendo o agendamento relacionado
	 */
	public Scheduling getScheduling() {
		return scheduling;
	}

	/**
	 * Obtém a lista de serviços que foram efetivamente prestados.
	 * 
	 * @return List<Service> contendo todos os serviços realizados
	 */
	public List<Service> getServicesList() {
		return services_list;
	}

	/**
	 * Define o ID único do registro de prestação de serviço.
	 * 
	 * @param id int contendo o novo identificador
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * Define se foi aplicado desconto nesta prestação de serviço.
	 * 
	 * @param discount boolean true para indicar desconto, false caso contrário
	 */
	public void setDiscount(boolean discount) {
		this.discount = discount;
	}

	/**
	 * Define o valor total cobrado pelos serviços.
	 * 
	 * @param amount_charged float contendo o valor cobrado em reais
	 */
	public void setAmountCharged(float amount_charged) {
		this.amount_charged = amount_charged;
	}

	/**
	 * Define a data de realização dos serviços.
	 * 
	 * @param date Date contendo a data de execução
	 */
	public void setDate(Date date) {
		this.date = date;
	}

	/**
	 * Define o cão que recebeu os serviços.
	 * 
	 * @param dog Dog contendo as informações do cão
	 */
	public void setDog(Dog dog) {
		this.dog = dog;
	}

	/**
	 * Define o agendamento original relacionado a esta prestação.
	 * 
	 * @param scheduling Scheduling contendo o agendamento de origem
	 */
	public void setScheduling(Scheduling scheduling) {
		this.scheduling = scheduling;
	}

	/**
	 * Define a lista completa de serviços prestados.
	 * 
	 * @param services_list List<Service> contendo os serviços realizados
	 */
	public void setServicesList(List<Service> services_list) {
		this.services_list = services_list;
	}
}
