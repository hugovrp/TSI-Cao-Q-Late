package br.petshop.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.petshop.database.ConnectionFactory;
import br.petshop.model.Dog;
import br.petshop.model.Scheduling;
import br.petshop.model.Service;
import br.petshop.model.ServiceProvision;

/**
 * Classe de acesso a dados (DAO) para a entidade ServiceProvision.
 * Responsável por todas as operações de banco de dados relacionadas às prestações de serviços realizadas no petshop.
 * 
 * Esta classe gerencia o registro de serviços concluídos, geração de relatórios financeiros e cálculo de receitas. 
 * Implementa regras de negócio como aplicação automática de descontos.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ServiceProvisionDAO {
    private Connection connection;
    
    /**
     * Construtor padrão que inicializa a conexão com o banco de dados.
     * Obtém uma conexão através da ConnectionFactory.
     */
    public ServiceProvisionDAO() {
        this.connection = ConnectionFactory.getConnection();
    }
    
    /**
     * Registra a conclusão de um agendamento, criando um registro de prestação de serviço.
     * 
     * Este método implementa uma transação completa que:
     *  - Valida se o agendamento existe e está com status "Agendado"
     *  - Calcula o valor total dos serviços
     *  - Aplica desconto de 10% automaticamente se houver 3 ou mais serviços
     *  - Atualiza o status do agendamento para "Finalizado"
     *  - Cria o registro de prestação de serviço com a data atual
     *  - Associa todos os serviços à prestação
     * 
     * 
     * A operação é atômica: ou todas as etapas são concluídas com sucesso, ou nenhuma alteração é mantida 
     * (rollback em caso de erro).
     * 
     * @param scheduling_id int identificador do agendamento a ser finalizado
     * @return ServiceProvision objeto contendo todos os dados da prestação criada, null se falhar
     */
    public ServiceProvision register_provision(int scheduling_id) {
    	String check_sql = "select sc.id, sc.dog, sc.date, d.name as dog_name " +
    					   "from scheduling sc join dog d on d.id = sc.dog " +
    					   "where sc.id = ? and sc.status = 'Agendado'";
    	
    	try(PreparedStatement check_statement = connection.prepareStatement(check_sql)) {
    		check_statement.setInt(1, scheduling_id);
    		ResultSet result = check_statement.executeQuery();
    		
    		if(!result.next()) {
    			return null;
    		}
    		
    		int dog_id = result.getInt("dog");
    		Date scheduling_date = result.getDate("date");
    		String dog_name = result.getString("dog_name");
    		
    		SchedulingDAO dao = new SchedulingDAO();
    		List<Service> services = dao.list_by_scheduling(scheduling_id);
    		
    		if(services.isEmpty()) {
    			return null;
    		}
    		
    		// Calcula valor total
    		float total_value = 0;
    		for(Service service : services) {
    			total_value += service.getPrice();
    		}
    		
    		// Aplica desconto de 10% se houver 3 ou mais serviços
    		boolean has_discount = services.size() >= 3;
    		float amount_charged = total_value;
    		
    		if(has_discount) {
    			amount_charged = total_value * 0.9f;
    		}
    		
    		connection.setAutoCommit(false);
    		
    		try {
    			// Atualiza status do agendamento
    			String update_sql = "update scheduling set status = 'Finalizado' where id = ?";
    			try(PreparedStatement update_statement = connection.prepareStatement(update_sql)) {
    				update_statement.setInt(1, scheduling_id);
    				update_statement.executeUpdate();
    			}
    			
    			// Insere a prestação de serviço
    			String insert_sql = "insert into service_provision (scheduling_id, dog_id, date, discount, amount_charged) values (?,?,?,?,?)";
    			
    			int provision_id;
    			try(PreparedStatement insert_statement = connection.prepareStatement(insert_sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
    				insert_statement.setInt(1, scheduling_id);
    				insert_statement.setInt(2, dog_id);
    				insert_statement.setDate(3, new Date(System.currentTimeMillis()));
    				insert_statement.setBoolean(4, has_discount);
    				insert_statement.setFloat(5, amount_charged);
    				
    				insert_statement.executeUpdate();
    				
    				ResultSet generated_keys = insert_statement.getGeneratedKeys();
    				if(generated_keys.next()) {
                        provision_id = generated_keys.getInt(1);
                    } 
    				else {
                        throw new SQLException("Falha ao obter ID da prestação");
                    }	
    			}
    			
    			// Insere os serviços associados à prestação
                String insert_services = "insert into service_provision_service " +
                                       "(service_provision_id, service_id) values (?, ?)";
                
                try (PreparedStatement services_stmt = connection.prepareStatement(insert_services)) {
                    for (Service service : services) {
                        services_stmt.setInt(1, provision_id);
                        services_stmt.setInt(2, service.getId());
                        services_stmt.addBatch();
                    }
                    services_stmt.executeBatch();
                }
                
                connection.commit();
                
                // Cria e retorna o objeto ServiceProvision
                ServiceProvision provision = new ServiceProvision();
                provision.setId(provision_id);
                provision.setDate(new Date(System.currentTimeMillis()));
                provision.setDiscount(has_discount);
                provision.setAmountCharged(amount_charged);
                
                Dog dog = new Dog();
                dog.setId(dog_id);
                dog.setName(dog_name);
                provision.setDog(dog);
                
                Scheduling scheduling = new Scheduling();
                scheduling.setId(scheduling_id);
                scheduling.setDate(scheduling_date);
                provision.setScheduling(scheduling);
                
                provision.setServicesList(services);
                
                return provision;
    		} catch (SQLException e) {
                connection.rollback();
                throw e;
            } 
    		finally {
                connection.setAutoCommit(true);
            }
    	} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
    }
    
    /**
     * Gera um relatório de prestações de serviço em um período específico.
     * 
     * Retorna todas as prestações realizadas entre as datas especificadas, incluindo informações completas de 
     * serviços, valores e cães atendidos.
     * Os resultados são ordenados por data decrescente (mais recentes primeiro).
     * 
     * @param start_date Date data inicial do período (inclusive)
     * @param end_date Date data final do período (inclusive)
     * @return List<ServiceProvision> lista de prestações no período, lista vazia se nenhuma encontrada
     */
    public List<ServiceProvision> provision_report(Date start_date, Date end_date) {
        List<ServiceProvision> provisions = new ArrayList<>();
        
        String cmd_sql = "select sp.id as provision_id, sp.date, sp.discount, sp.amount_charged, " +
                        "sp.scheduling_id, d.id as dog_id, d.name as dog_name, " +
                        "s.id as service_id, s.name as service_name, s.price " +
                        "from service_provision sp " +
                        "join dog d on d.id = sp.dog_id " +
                        "join service_provision_service sps on sps.service_provision_id = sp.id " +
                        "join service s on s.id = sps.service_id " +
                        "where sp.date >= ? and sp.date <= ? " +
                        "order by sp.date desc, sp.id";
        
        try (PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
            statement.setDate(1, start_date);
            statement.setDate(2, end_date);
            ResultSet result = statement.executeQuery();
            
            int last_provision_id = -1;
            ServiceProvision current = null;
            
            while (result.next()) {
                int provision_id = result.getInt("provision_id");
                
                // Nova prestação de serviço
                if (provision_id != last_provision_id) {
                    current = new ServiceProvision();
                    current.setId(provision_id);
                    current.setDate(result.getDate("date"));
                    current.setDiscount(result.getBoolean("discount"));
                    current.setAmountCharged(result.getFloat("amount_charged"));
                    
                    Dog dog = new Dog();
                    dog.setId(result.getInt("dog_id"));
                    dog.setName(result.getString("dog_name"));
                    current.setDog(dog);
                    
                    Scheduling scheduling = new Scheduling();
                    scheduling.setId(result.getInt("scheduling_id"));
                    current.setScheduling(scheduling);
                    
                    current.setServicesList(new ArrayList<>());
                    provisions.add(current);
                    
                    last_provision_id = provision_id;
                }
                
                // Adiciona serviço à prestação atual
                Service service = new Service();
                service.setId(result.getInt("service_id"));
                service.setName(result.getString("service_name"));
                service.setPrice(result.getFloat("price"));
                
                current.getServicesList().add(service);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return provisions;
    }
    
    /**
     * Calcula a receita total gerada em um período específico.
     * 
     * Soma todos os valores cobrados (amount_charged) das prestações realizadas no período, 
     * já considerando os descontos aplicados.
     * 
     * @param start_date Date data inicial do período (inclusive)
     * @param end_date Date data final do período (inclusive)
     * @return float valor total da receita no período, 0.0 se não houver prestações
     */
    public float calculate_total_revenue(Date start_date, Date end_date) {
        String sql = "select sum(amount_charged) as total from service_provision " +
                    "where date >= ? and date <= ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDate(1, start_date);
            stmt.setDate(2, end_date);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getFloat("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0f;
    }
}