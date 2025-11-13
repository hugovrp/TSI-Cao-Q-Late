<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Lista de Cães</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #F4F4F4;
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #264653 0%, #1a3540 100%);
            color: white;
            padding: 30px 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            padding: 0 25px 30px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 20px;
        }

        .sidebar-header h1 {
            font-family: 'Poppins', sans-serif;
            font-size: 1.8em;
        }

        .sidebar ul {
            list-style: none;
            flex: 1;
        }

        .sidebar li {
            margin: 5px 15px;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 15px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-size: 0.95em;
        }

        .sidebar a:hover {
            background: rgba(42, 157, 143, 0.2);
            color: white;
            transform: translateX(5px);
        }

        .sidebar a.active {
            background: #2A9D8F;
            color: white;
            font-weight: 600;
        }

        .sidebar-footer {
            padding: 20px 25px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logout-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            padding: 12px;
            background: rgba(231, 76, 60, 0.2);
            color: #ff6b6b;
            border: 1px solid rgba(231, 76, 60, 0.3);
            border-radius: 10px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: #e74c3c;
            color: white;
            border-color: #e74c3c;
        }

        .main-content {
            margin-left: 280px;
            flex: 1;
            padding: 30px 40px;
        }

        .top-bar {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-bar h2 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            font-size: 1.8em;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #F4F4F4;
            color: #264653;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: #264653;
            color: white;
        }

        .search-section {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .search-section h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            margin-bottom: 15px;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: flex-end;
        }

        .form-group {
            flex: 1;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.9em;
        }

        .search-input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #2A9D8F;
        }

        .search-btn {
            padding: 12px 30px;
            background: #2A9D8F;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            background: #264653;
        }

        .table-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .table-header {
            padding: 20px 30px;
            border-bottom: 2px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            font-size: 1.3em;
        }

        .dog-count {
            background: #2A9D8F;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f8f9fa;
        }

        th {
            padding: 15px 20px;
            text-align: left;
            font-weight: 600;
            color: #264653;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            padding: 18px 20px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: #f8f9fa;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .size-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .size-small {
            background: #e3f2fd;
            color: #1976d2;
        }

        .size-medium {
            background: #fff3e0;
            color: #f57c00;
        }

        .size-large {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 4em;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-family: 'Poppins', sans-serif;
            color: #666;
            margin-bottom: 10px;
        }

        .empty-state p {
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }

            .sidebar-header h1,
            .sidebar a span,
            .sidebar-footer {
                display: none;
            }

            .main-content {
                margin-left: 70px;
                padding: 20px;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 600px;
            }
        }
    </style>
</head>

<body>
    <jsp:useBean id="dao" class="br.petshop.dao.DogDAO"/>
    <jsp:useBean id="client" class="br.petshop.model.Client"/>
    <jsp:setProperty property="id" name="client" value="${param.id}"/>

    <div class="sidebar">
        <div class="sidebar-header">
            <h1>🐕 Cão Q-Late</h1>
        </div>

        <ul>
            <li><a href="index.jsp">📊 <span>Dashboard</span></a></li>
            <li><a href="client_home.jsp">👥 <span>Clientes</span></a></li>
            <li><a href="dog_home.jsp" class="active">🐶 <span>Cães</span></a></li>
            <li><a href="service_home.jsp">✂️ <span>Serviços</span></a></li>
            <li><a href="scheduling_home.jsp">📅 <span>Agendamentos</span></a></li>
            <li><a href="service_provision_home.jsp">🎯 <span>Prestar Serviços</span></a></li>
        </ul>

        <div class="sidebar-footer">
            <c:if test="${sessionScope.status == true}">
                <a href="controller?handler=Logout" class="logout-btn">
                    🚪 <span>Sair</span>
                </a>
            </c:if>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <h2>📋 Lista de Cães</h2>
            <a href="dog_home.jsp" class="back-btn">← Voltar</a>
        </div>

        <div class="search-section">
            <h3>🔍 Buscar Cães por Cliente</h3>
            <form class="search-form" action="" method="get">
                <div class="form-group">
                    <label for="id">ID do Cliente</label>
                    <input type="number" id="id" name="id" class="search-input" 
                           value="${param.id}" min="1" placeholder="Digite o ID do cliente">
                </div>
                <button type="submit" class="search-btn">🔍 Buscar</button>
            </form>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${not empty param.id}">
                    <c:set var="dogList" value="${dao.dog_list(client)}" />
                    <div class="table-header">
                        <h3>Cães Cadastrados</h3>
                        <span class="dog-count">${dogList.size()} cão(ães)</span>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty dogList}">
                            <div class="empty-state">
                                <div class="empty-state-icon">🐶</div>
                                <h3>Nenhum cão encontrado</h3>
                                <p>Este cliente não possui cães cadastrados</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Nome</th>
                                        <th>Raça</th>
                                        <th>Porte</th>
                                        <th>Dono</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="dog" items="${dogList}">
                                        <tr>
                                            <td><strong>${dog.name}</strong></td>
                                            <td>${dog.breed}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${dog.size.name() == 'SMALL'}">
                                                        <span class="size-badge size-small">🐕 Pequeno</span>
                                                    </c:when>
                                                    <c:when test="${dog.size.name() == 'MEDIUM'}">
                                                        <span class="size-badge size-medium">🐕 Médio</span>
                                                    </c:when>
                                                    <c:when test="${dog.size.name() == 'LARGE'}">
                                                        <span class="size-badge size-large">🐕 Grande</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${dog.owner.name}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">🔍</div>
                        <h3>Busque por um cliente</h3>
                        <p>Informe o ID de um cliente acima para listar seus cães cadastrados</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>