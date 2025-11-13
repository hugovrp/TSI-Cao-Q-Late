<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Agendamentos</title>
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

        .filter-section {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .filter-section h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            margin-bottom: 15px;
        }

        .filter-form {
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

        .date-input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
        }

        .date-input:focus {
            outline: none;
            border-color: #2A9D8F;
        }

        .filter-btn {
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

        .filter-btn:hover {
            background: #264653;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: none;
            align-items: center;
            gap: 10px;
            font-size: 0.95em;
        }

        .alert.show {
            display: flex;
        }

        .alert.error {
            background: #fff5f5;
            border: 2px solid #e74c3c;
            color: #e74c3c;
        }

        .alert.success {
            background: #f0fdf4;
            border: 2px solid #2A9D8F;
            color: #2A9D8F;
        }

        .schedulings-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .schedulings-header {
            padding: 20px 30px;
            border-bottom: 2px solid #f0f0f0;
        }

        .schedulings-header h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            font-size: 1.3em;
        }

        .scheduling-item {
            border-bottom: 1px solid #f0f0f0;
            padding: 20px 30px;
            transition: all 0.3s ease;
        }

        .scheduling-item:hover {
            background: #f8f9fa;
        }

        .scheduling-item:last-child {
            border-bottom: none;
        }

        .scheduling-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .scheduling-date {
            font-weight: 600;
            color: #264653;
            font-size: 1.1em;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .status-agendado {
            background: #e3f2fd;
            color: #1976d2;
        }

        .status-cancelado {
            background: #ffebee;
            color: #c62828;
        }

        .status-finalizado {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .scheduling-details {
            margin-bottom: 15px;
        }

        .dog-name {
            font-size: 1.05em;
            color: #333;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .services-list {
            background: #f8f9fa;
            padding: 12px 15px;
            border-radius: 8px;
        }

        .services-list h4 {
            color: #666;
            font-size: 0.85em;
            margin-bottom: 8px;
        }

        .service-item {
            padding: 5px 0;
            color: #333;
            font-size: 0.95em;
        }

        .service-price {
            color: #2A9D8F;
            font-weight: 600;
        }

        .scheduling-actions {
            display: flex;
            gap: 10px;
        }

        .cancel-btn {
            padding: 8px 20px;
            background: #fff5f5;
            color: #e74c3c;
            border: 2px solid #e74c3c;
            border-radius: 8px;
            font-size: 0.9em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .cancel-btn:hover {
            background: #e74c3c;
            color: white;
        }

        .cannot-cancel {
            padding: 8px 20px;
            background: #f5f5f5;
            color: #999;
            border-radius: 8px;
            font-size: 0.85em;
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

            .filter-form {
                flex-direction: column;
            }

            .scheduling-header {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>

<body>
    <jsp:useBean id="now" class="java.util.Date" scope="page" />

    <div class="sidebar">
        <div class="sidebar-header">
            <h1>🐕 Cão Q-Late</h1>
        </div>

        <ul>
            <li><a href="index.jsp">📊 <span>Dashboard</span></a></li>
            <li><a href="client_home.jsp">👥 <span>Clientes</span></a></li>
            <li><a href="dog_home.jsp">🐶 <span>Cães</span></a></li>
            <li><a href="service_home.jsp">✂️ <span>Serviços</span></a></li>
            <li><a href="scheduling_home.jsp" class="active">📅 <span>Agendamentos</span></a></li>
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
            <h2>📋 Lista de Agendamentos</h2>
            <a href="scheduling_home.jsp" class="back-btn">← Voltar</a>
        </div>

        <div class="filter-section">
            <h3>🔍 Filtrar Agendamentos</h3>
            <form action="controller" method="post" class="filter-form">
                <input type="hidden" name="handler" value="ListScheduling">
                <div class="form-group">
                    <label for="start_date">Data Inicial</label>
                    <input type="date" id="start_date" name="start_date" class="date-input" 
                           value="${startDate}" required>
                </div>
                <button type="submit" class="filter-btn">🔍 Filtrar</button>
            </form>
        </div>

        <div id="alertBox" class="alert"></div>

        <div class="schedulings-container">
            <div class="schedulings-header">
                <h3>Agendamentos</h3>
            </div>

            <c:choose>
                <c:when test="${not empty schedulings}">
                    <c:forEach var="s" items="${schedulings}">
                        <div class="scheduling-item">
                            <div class="scheduling-header">
                                <div>
                                    <div class="scheduling-date">
                                        📅 <fmt:formatDate value="${s.date}" pattern="dd/MM/yyyy"/>
                                    </div>
                                    <div class="dog-name">
                                        🐶 ${s.dog.name}
                                    </div>
                                </div>
                                <span class="status-badge status-${s.status.toLowerCase()}">${s.status}</span>
                            </div>

                            <div class="scheduling-details">
                                <div class="services-list">
                                    <h4>✂️ Serviços Agendados:</h4>
                                    <c:forEach var="svc" items="${s.servicesList}">
                                        <div class="service-item">
                                            ${svc.name} - <span class="service-price">R$ <fmt:formatNumber value="${svc.price}" pattern="#,##0.00"/></span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="scheduling-actions">
                                <c:choose>
                                    <c:when test="${s.status eq 'Cancelado'}">
                                        <span class="cannot-cancel">❌ Agendamento cancelado</span>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${s.date.time - now.time > 86400000}">
                                                <form action="controller" method="post" style="display:inline;">
                                                    <input type="hidden" name="handler" value="CancelScheduling">
                                                    <input type="hidden" name="id" value="${s.id}">
                                                    <input type="hidden" name="date" value="${s.date}">
                                                    <button type="submit" class="cancel-btn" 
                                                            onclick="return confirm('Tem certeza que deseja cancelar este agendamento?')">
                                                        ❌ Cancelar Agendamento
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="cannot-cancel">⏰ Não pode cancelar (menos de 24h)</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">📅</div>
                        <h3>Nenhum agendamento encontrado</h3>
                        <p>Não há agendamentos para a data selecionada</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Define data mínima como hoje
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('start_date').setAttribute('min', today);

        function showAlert(message, type) {
            const alertBox = document.getElementById('alertBox');
            alertBox.textContent = (type === 'error' ? '❌ ' : '✅ ') + message;
            alertBox.className = 'alert ' + type + ' show';

            setTimeout(() => {
                alertBox.classList.remove('show');
            }, 5000);
        }

        // Verifica mensagens do servidor
        <c:if test="${not empty message}">
            showAlert('${message}', 'success');
        </c:if>
        <c:if test="${not empty error}">
            showAlert('${error}', 'error');
        </c:if>
    </script>
</body>
</html>