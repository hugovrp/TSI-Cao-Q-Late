package br.petshop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.petshop.database.ConnectionFactory;
import br.petshop.model.Admin;

/**
 * Classe de acesso a dados (DAO) para a entidade Admin.
 * Responsável por todas as operações de banco de dados relacionadas aos administradores do sistema.
 * 
 * Esta classe gerencia o registro, autenticação e atualização de credenciais dos administradores do petshop.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class AdminDAO {
    private Connection connection;
    
    /**
     * Construtor padrão que inicializa a conexão com o banco de dados.
     * Obtém uma conexão através da ConnectionFactory.
     */
    public AdminDAO() {
        this.connection = ConnectionFactory.getConnection();
    }
    
    /**
     * Verifica se já existe um administrador cadastrado no sistema.
     * O sistema permite apenas um administrador.
     * 
     * @return boolean true se existe pelo menos um administrador, false caso contrário
     */
    public boolean has_admin() {
        String cmd_sql = "select count(*) from admin";
        try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
            ResultSet result = statement.executeQuery();
            if(result.next()) {
                return result.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Registra um novo administrador no sistema.
     * 
     * A senha deve vir já hasheada (SHA-256) do frontend por segurança.
     * O sistema permite apenas um administrador cadastrado.
     * 
     * @param admin objeto Admin contendo login e senha (já hasheada) do novo administrador
     * @return boolean true se o registro foi bem-sucedido, false se já existe um admin ou ocorreu erro
     */
    public boolean register_admin(Admin admin) {
        if(has_admin()) {
            System.out.println("Já existe um administrador cadastrado!");
            return false;
        }
        
        String cmd_sql = "insert into admin (login, password) values (?,?)";
        
        try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
            statement.setString(1, admin.getLogin());
            statement.setString(2, admin.getPassword()); // Senha já hasheada
            statement.execute();
            return true;
        } catch (SQLException e) {
            if (e.getMessage().contains("CHECK constraint") || e.getMessage().contains("Duplicate")) {
                System.err.println("Já existe um administrador cadastrado!");
            } else {
                e.printStackTrace();
            }
        }
        return false;
    }
    
    /**
     * Valida as credenciais de login do administrador.
     * 
     * Compara o hash da senha fornecida com o hash armazenado no banco.
     * O passwordHash já vem do frontend em formato SHA-256.
     * 
     * @param login String contendo o login do administrador
     * @param passwordHash String contendo a senha em formato hash SHA-256
     * @return Admin objeto Admin com as credenciais se válidas, null se inválidas
     */
    public Admin validate_credentials(String login, String passwordHash) {
        String cmd_sql = "select * from admin where login=? and password=?";
        Admin admin = null;
        
        try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
            statement.setString(1, login);
            statement.setString(2, passwordHash);
            ResultSet result = statement.executeQuery();
            
            if(result.next()) {
                admin = new Admin();
                admin.setLogin(result.getString("login"));
                admin.setPassword(result.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }
    
    /**
     * Atualiza a senha de um administrador existente.
     * 
     * Útil para funcionalidades de recuperação de senha ou migração de senhas.
     * O newPasswordHash deve vir já hasheado (SHA-256).
     * 
     * @param login String contendo o login do administrador
     * @param newPasswordHash String contendo a nova senha em formato hash SHA-256
     * @return boolean true se a atualização foi bem-sucedida, false caso contrário
     */
    public boolean updateAdminPassword(String login, String newPasswordHash) {
        String cmd_sql = "update admin set password=? where login=?";
        
        try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
            statement.setString(1, newPasswordHash);
            statement.setString(2, login);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}