# 🐕 Cão Q-Late - Sistema de Gerenciamento para Petshop

> Sistema web desenvolvido em Java para gestão completa de petshops, incluindo cadastro de clientes, pets, agendamentos e controle financeiro.

[![Java](https://img.shields.io/badge/Java-24-orange?style=for-the-badge&logo=openjdk)](https://openjdk.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-42.7.7-blue?style=for-the-badge&logo=postgresql)](https://www.postgresql.org/)
[![Apache Tomcat](https://img.shields.io/badge/Tomcat-10.1-yellow?style=for-the-badge&logo=apachetomcat)](https://tomcat.apache.org/)
[![Maven](https://img.shields.io/badge/Maven-3.x-red?style=for-the-badge&logo=apachemaven)](https://maven.apache.org/)

---

## 📋 Sobre o Projeto

**Cão Q-Late** é um sistema completo de gerenciamento para petshops que permite:

- 👥 Cadastro e gestão de clientes
- 🐶 Registro de cães com informações detalhadas (raça, porte, proprietário)
- ✂️ Catálogo de serviços e precificação dinâmica
- 📅 Sistema de agendamentos com validação de disponibilidade
- 💰 Controle de prestação de serviços com descontos automáticos
- 📊 Relatórios financeiros e histórico de atendimentos

> **Disciplina**: Desenvolvimento de Aplicações Web  
> **Curso**: Sistemas para Internet  
> **Tipo**: Trabalho Individual 

---

## 🚀 Tecnologias

### Backend
- **Java 24** - Linguagem principal
- **Jakarta Servlet/JSP** - Framework web
- **JSTL** - Template engine
- **Maven** - Gerenciamento de dependências

### Banco de Dados
- **PostgreSQL 42.7.7** - Banco de dados relacional
- **JDBC** - Conectividade com banco

### Servidor
- **Apache Tomcat 10.1** - Container de servlets

### Frontend
- **HTML5 + CSS3** - Interface moderna e responsiva
- **JavaScript (ES6+)** - Validações e interatividade
- **SHA-256** - Hash de senhas no frontend

---

## 📦 Pré-requisitos

- [JDK 24+](https://openjdk.org/projects/jdk/24/)
- [Apache Tomcat 10.1+](https://tomcat.apache.org/download-10.cgi)
- [PostgreSQL 12+](https://www.postgresql.org/download/)
- [Maven 3.x](https://maven.apache.org/download.cgi)

---

## 🔐 Credenciais de Acesso

**Login:** `admin`  
**Senha:** `admin`

> ⚠️ A senha é hasheada com SHA-256 no frontend antes do envio. Hash armazenado: `8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918`

---

## 💻 Arquitetura do Sistema

### Padrão MVC

```
┌─────────────┐      ┌──────────────┐      ┌──────────┐
│   View      │ ───> │  Controller  │ ───> │   Model  │
│  (JSP)      │ <─── │  (Servlet)   │ <─── │  (DAO)   │
└─────────────┘      └──────────────┘      └──────────┘
                             │
                             ↓
                     ┌──────────────┐
                     │   Database   │
                     │ (PostgreSQL) │
                     └──────────────┘
```

## 🎯 Funcionalidades Principais

### 1. Sistema de Login
Hash de senha no frontend usando Web Crypto API:

```javascript
async function hashPassword(password) {
    const encoder = new TextEncoder();
    const data = encoder.encode(password);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}
```

### 2. Cadastro de Clientes e Cães
O sistema permite cadastro integrado - ao cadastrar um cliente, seus cães podem ser registrados simultaneamente:

```java
public boolean register_client(Client client) {
    // Insere cliente
    // Se cliente possui cães, cadastra automaticamente
    if(client.getDogList() != null && !client.getDogList().isEmpty()) {
        DogDAO dog_dao = new DogDAO();
        for(Dog dog : client.getDogList()) {
            dog.setOwner(client);
            dog_dao.register_dog(dog);
        }
    }
    return true;
}
```

### 3. Sistema de Agendamentos
Validações automáticas de disponibilidade:

```java
// Verifica se o cão pertence ao cliente
public boolean dog_belongs_client(int dog_id, int client_id)

// Verifica disponibilidade da data
public boolean is_date_available(int dog_id, Date date)

// Registra agendamento com múltiplos serviços
public boolean register_scheduling(Scheduling scheduling)
```

### 4. Prestação de Serviços com Desconto Automático

O sistema aplica **10% de desconto** automaticamente quando 3 ou mais serviços são realizados:

```java
public ServiceProvision register_provision(int scheduling_id) {
    // Busca serviços do agendamento
    List<Service> services = dao.list_by_scheduling(scheduling_id);
    
    // Calcula total
    float total = services.stream()
        .map(Service::getPrice)
        .reduce(0f, Float::sum);
    
    // Aplica desconto
    boolean hasDiscount = services.size() >= 3;
    float amountCharged = hasDiscount ? total * 0.9f : total;
    
    // Registra prestação e atualiza agendamento para "Finalizado"
}
```

### 5. Relatórios Financeiros

```java
// Relatório de prestações em período
public List<ServiceProvision> provision_report(Date startDate, Date endDate)

// Cálculo de receita total
public float calculate_total_revenue(Date startDate, Date endDate)
```

---

## 🎨 Interface do Usuário

O sistema possui uma interface moderna e responsiva com:

- 🎨 **Design System** personalizado com paleta de cores Teal (#2A9D8F) e Dark Blue (#264653)
- 📱 **Layout Responsivo** que se adapta a mobile, tablet e desktop
- ✨ **Animações suaves** em hover e transições
- 🔍 **Busca em tempo real** nas listagens
- ✅ **Validação de formulários** no frontend
- 🎯 **Dashboard intuitivo** com acesso rápido às funcionalidades

---

## 🔒 Segurança

- ✅ Hash SHA-256 de senhas no frontend
- ✅ Prepared Statements (proteção contra SQL Injection)
- ✅ Validação de permissões (apenas um admin)
- ✅ Validação de relacionamentos (cão pertence ao cliente)
- ✅ Transações ACID para operações críticas

---

## 📊 Regras de Negócio

1. **Único Administrador**: Sistema permite apenas um usuário admin
2. **Validação de Propriedade**: Apenas o dono pode agendar serviços para seu cão
3. **Desconto Automático**: 10% de desconto em 3+ serviços na mesma prestação
4. **Status de Agendamento**: `Agendado` → `Finalizado` ou `Cancelado`
5. **Histórico Completo**: Todos os serviços prestados são mantidos no histórico

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

---

## 📝 Licença

Este projeto é um trabalho acadêmico desenvolvido para a disciplina de **Desenvolvimento de Aplicações Web** do curso de **Sistemas para Internet**.

---

## 👨‍💻 Autor

**Hugo Vinícius Rodrigues Pereira**

[![GitHub](https://img.shields.io/badge/GitHub-hugovrp-black?style=flat-square&logo=github)](https://github.com/hugovrp)

---

## 📞 Suporte

Encontrou um bug ou tem uma sugestão? [Abra uma issue](https://github.com/hugovrp/TSI-Cao-Q-Late/issues)
