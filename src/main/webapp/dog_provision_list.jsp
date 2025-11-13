<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Histórico de Serviços</title>
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

        .dog-info-card {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .dog-avatar {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5em;
        }

        .dog-details h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            font-size: 1.5em;
            margin-bottom: 8px;
        }

        .dog-meta {
            display: flex;
            gap: 20px;
            color: #666;
            font-size: 0.95em;
        }

        .dog-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .history-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .history-header {
            padding: 20px 30px;
            border-bottom: 2px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .history-header h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            font-size: 1.3em;
        }

        .provision-count {
            background: #2A9D8F;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
        }

        .provision-list {
            padding: 20px 30px;
        }

        .provision-item {
            border: 2px solid #f0f0f0;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        .provision-item:hover {
            border-color: #2A9D8F;
            box-shadow: 0 2px 10px rgba(42, 157, 143, 0.1);
        }

        .provision-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f0f0f0;
        }

        .provision-date {
            font-weight: 600;
            color: #264653;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .provision-value {
            font-size: 1.3em;
            font-weight: 700;
            color: #2A9D8F;
        }

        .services-list {
            margin-bottom: 15px;
        }

        .services-list h4 {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }

        .service-tag {
            display: inline-block;
            background: #f8f9fa;
            padding: 6px 12px;
            border-radius: 6px;
            margin: 4px;
            font-size: 0.9em;
            color: #333;
        }

        .discount-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: #fff3e0;
            color: #f57c00;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
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

            .dog-info-card {
                flex-direction: column;
                text-align: center;
            }

            .dog-meta {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>

<body>
    <jsp:useBean id="dogDao" class="br.petshop.dao.DogDAO"/>
    
    <c:if test="${not empty param.dog_id}">
        <c:set var="dog" value="${dogDao.find_dog(param.dog_id)}" />
        <c:set var="serviceHistory" value="${dogDao.dog_service_history(param.dog_id)}" />
    </c:if>

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
            <h2>📊 Histórico de Serviços</h2>
            <a href="dog_home.jsp" class="back-btn">← Voltar</a>
        </div>

        <div class="search-section">
            <h3>🔍 Buscar Histórico por Cão</h3>
            <form class="search-form" action="" method="get">
                <div class="form-group">
                    <label for="dog_id">ID do Cão</label>
                    <input type="number" id="dog_id" name="dog_id" class="search-input" 
                           value="${param.dog_id}" min="1" placeholder="Digite o ID do cão">
                </div>
                <button type="submit" class="search-btn">🔍 Buscar</button>
            </form>
        </div>

        <c:choose>
            <c:when test="${not empty param.dog_id}">
                <c:choose>
                    <c:when test="${not empty dog}">
                        <div class="dog-info-card">
                            <div class="dog-avatar">🐶</div>
                            <div class="dog-details">
                                <h3>${dog.name}</h3>
                                <div class="dog-meta">
                                    <span>🔖 ${dog.breed}</span>
                                    <span>📏 
                                        <c:choose>
                                            <c:when test="${dog.size.name() == 'SMALL'}">Pequeno</c:when>
                                            <c:when test="${dog.size.name() == 'MEDIUM'}">Médio</c:when>
                                            <c:when test="${dog.size.name() == 'LARGE'}">Grande</c:when>
                                        </c:choose>
                                    </span>
                                    <span>👤 ${dog.owner.name}</span>
                                    <span>📞 ${dog.owner.telephone}</span>
                                </div>
                            </div>
                        </div>

                        <div class="history-container">
                            <div class="history-header">
                                <h3>Histórico de Atendimentos</h3>
                                <span class="provision-count">${serviceHistory.size()} atendimento(s)</span>
                            </div>

                            <c:choose>
                                <c:when test="${empty serviceHistory}">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">📋</div>
                                        <h3>Nenhum serviço prestado</h3>
                                        <p>Este cão ainda não possui histórico de atendimentos</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="provision-list">
                                        <c:forEach var="provision" items="${serviceHistory}">
                                            <div class="provision-item">
                                                <div class="provision-header">
                                                    <div class="provision-date">
                                                        📅 <fmt:formatDate value="${provision.date}" pattern="dd/MM/yyyy"/>
                                                    </div>
                                                    <div class="provision-value">
                                                        R$ <fmt:formatNumber value="${provision.amountCharged}" 
                                                                           pattern="#,##0.00"/>
                                                    </div>
                                                </div>

                                                <div class="services-list">
                                                    <h4>✂️ Serviços realizados:</h4>
                                                    <c:forEach var="service" items="${provision.servicesList}">
                                                        <span class="service-tag">
                                                            ${service.name} - R$ <fmt:formatNumber value="${service.price}" 
                                                                                                  pattern="#,##0.00"/>
                                                        </span>
                                                    </c:forEach>
                                                </div>

                                                <c:if test="${provision.discount}">
                                                    <div>
                                                        <span class="discount-badge">
                                                            🎉 Desconto de 10% aplicado (3+ serviços)
                                                        </span>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="history-container">
                            <div class="empty-state">
                                <div class="empty-state-icon">❌</div>
                                <h3>Cão não encontrado</h3>
                                <p>Não foi possível encontrar um cão com este ID</p>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <div class="history-container">
                    <div class="empty-state">
                        <div class="empty-state-icon">🔍</div>
                        <h3>Busque por um cão</h3>
                        <p>Informe o ID de um cão acima para visualizar seu histórico de serviços</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>