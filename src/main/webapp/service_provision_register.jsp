<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Lançar Prestação</title>
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

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.95em;
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

        .info-box {
            background: linear-gradient(135deg, #fff3e0, #ffe0b2);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            border-left: 5px solid #E9C46A;
        }

        .info-box h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-box ul {
            list-style: none;
            padding: 0;
        }

        .info-box li {
            padding: 8px 0;
            color: #555;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }

        .info-box li::before {
            content: '✓';
            color: #2A9D8F;
            font-weight: bold;
            flex-shrink: 0;
        }

        .form-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f8f9fa;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #264653;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e0e0e0;
        }

        td {
            padding: 18px 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
        }

        tbody tr {
            transition: all 0.3s ease;
            cursor: pointer;
        }

        tbody tr:hover {
            background: #f8f9fa;
        }

        tbody tr.selected {
            background: linear-gradient(135deg, rgba(42, 157, 143, 0.1), rgba(42, 157, 143, 0.05));
        }

        input[type="radio"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: #2A9D8F;
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            background: #e3f2fd;
            color: #1976d2;
        }

        .services-list {
            font-size: 0.95em;
            line-height: 1.6;
        }

        .submit-btn {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(42, 157, 143, 0.3);
            margin-top: 25px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(42, 157, 143, 0.4);
        }

        .submit-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
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

        .empty-state a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 25px;
            background: #2A9D8F;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .empty-state a:hover {
            background: #264653;
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

            .form-container {
                padding: 25px;
            }

            table {
                font-size: 0.9em;
            }

            th, td {
                padding: 10px;
            }
        }
    </style>
</head>

<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h1>🐕 Cão Q-Late</h1>
        </div>

        <ul>
            <li><a href="index.jsp">📊 <span>Dashboard</span></a></li>
            <li><a href="client_home.jsp">👥 <span>Clientes</span></a></li>
            <li><a href="dog_home.jsp">🐶 <span>Cães</span></a></li>
            <li><a href="service_home.jsp">✂️ <span>Serviços</span></a></li>
            <li><a href="scheduling_home.jsp">📅 <span>Agendamentos</span></a></li>
            <li><a href="service_provision_home.jsp" class="active">🎯 <span>Prestar Serviços</span></a></li>
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
            <h2>✅ Lançar Prestação de Serviço</h2>
            <a href="service_provision_home.jsp" class="back-btn">← Voltar</a>
        </div>

        <c:if test="${not empty error}">
            <div class="alert error">❌ ${error}</div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert success">✅ ${success}</div>
        </c:if>

        <div class="info-box">
            <h3>💡 Informações Importantes</h3>
            <ul>
                <li>Selecione um agendamento com status "Agendado" para lançar a prestação</li>
                <li>O sistema calculará automaticamente o valor com base nos serviços</li>
                <li><strong>Desconto de 10%:</strong> Aplicado automaticamente quando 3 ou mais serviços forem prestados</li>
                <li>O status do agendamento será alterado para "Finalizado" após o lançamento</li>
            </ul>
        </div>

        <div class="form-container">
            <c:choose>
                <c:when test="${empty schedulings}">
                    <div class="empty-state">
                        <div class="empty-state-icon">📅</div>
                        <h3>Nenhum agendamento disponível</h3>
                        <p>Não há agendamentos com status "Agendado" para lançar prestação.</p>
                        <a href="scheduling_home.jsp">📅 Ir para Agendamentos</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <form id="provisionForm" action="controller" method="post">
                        <input type="hidden" name="handler" value="RegisterProvision">
                        <input type="hidden" name="action" value="register">

                        <h3 style="font-family: 'Poppins', sans-serif; color: #264653; margin-bottom: 20px;">
                            Selecione o Agendamento
                        </h3>

                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th style="width: 60px;">Selecionar</th>
                                        <th>ID</th>
                                        <th>Data</th>
                                        <th>Cão</th>
                                        <th>Serviços</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="scheduling" items="${schedulings}">
                                        <c:if test="${scheduling.status == 'Agendado'}">
                                            <tr onclick="selectRow(this, ${scheduling.id})">
                                                <td>
                                                    <input type="radio" name="scheduling_id" 
                                                           value="${scheduling.id}" 
                                                           id="scheduling_${scheduling.id}" required>
                                                </td>
                                                <td><strong>#${scheduling.id}</strong></td>
                                                <td>
                                                    <fmt:formatDate value="${scheduling.date}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td>${scheduling.dog.name}</td>
                                                <td class="services-list">
                                                    <c:forEach var="service" items="${scheduling.servicesList}" varStatus="status">
                                                        ${service.name}<c:if test="${!status.last}">, </c:if>
                                                    </c:forEach>
                                                </td>
                                                <td><span class="status-badge">${scheduling.status}</span></td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <button type="submit" class="submit-btn">✅ Confirmar Prestação</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function selectRow(row, schedulingId) {
            // Remove seleção de todas as linhas
            const allRows = document.querySelectorAll('tbody tr');
            allRows.forEach(r => r.classList.remove('selected'));

            // Adiciona seleção na linha clicada
            row.classList.add('selected');

            // Marca o radio button
            document.getElementById('scheduling_' + schedulingId).checked = true;
        }

        // Validação do formulário
        document.getElementById('provisionForm')?.addEventListener('submit', function(e) {
            const selectedRadio = document.querySelector('input[name="scheduling_id"]:checked');
            
            if(!selectedRadio) {
                e.preventDefault();
                alert('Por favor, selecione um agendamento.');
            }
        });
    </script>
</body>
</html>