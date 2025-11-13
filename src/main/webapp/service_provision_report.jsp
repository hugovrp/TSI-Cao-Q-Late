<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Relatório de Prestações</title>
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

        .filter-section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .filter-section h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            margin-bottom: 20px;
        }

        .filter-form {
            display: grid;
            grid-template-columns: 1fr 1fr auto;
            gap: 20px;
            align-items: flex-end;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95em;
        }

        .date-input {
            width: 100%;
            padding: 14px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
            background: #F4F4F4;
        }

        .date-input:focus {
            outline: none;
            border-color: #2A9D8F;
            background: white;
        }

        .filter-btn {
            padding: 14px 30px;
            background: #2A9D8F;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .filter-btn:hover {
            background: #264653;
        }

        .period-info {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border-left: 5px solid #2196f3;
        }

        .period-info p {
            color: #1565c0;
            font-weight: 600;
            font-size: 1.05em;
        }

        .table-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            margin-bottom: 25px;
        }

        .table-header {
            padding: 20px 30px;
            border-bottom: 2px solid #f0f0f0;
        }

        .table-header h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            font-size: 1.3em;
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

        .discount-badge {
            background: #4CAF50;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.8em;
            font-weight: 600;
            display: inline-block;
        }

        .total-row {
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
            color: white;
            font-weight: bold;
            font-size: 1.1em;
        }

        .total-row td {
            border-bottom: none;
        }

        .price-value {
            font-weight: 600;
            color: #2A9D8F;
            font-size: 1.05em;
        }

        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .summary-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .summary-card h4 {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .summary-value {
            font-size: 2em;
            font-weight: 700;
            color: #264653;
        }

        .summary-card:nth-child(1) .summary-value {
            color: #2A9D8F;
        }

        .summary-card:nth-child(2) {
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
            color: white;
        }

        .summary-card:nth-child(2) h4 {
            color: rgba(255, 255, 255, 0.9);
        }

        .summary-card:nth-child(2) .summary-value {
            color: white;
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

        @media (max-width: 968px) {
            .filter-form {
                grid-template-columns: 1fr;
            }
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
                min-width: 800px;
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
            <h2>📊 Relatório de Serviços Prestados</h2>
            <a href="service_provision_home.jsp" class="back-btn">← Voltar</a>
        </div>

        <c:if test="${not empty error}">
            <div class="alert error">❌ ${error}</div>
        </c:if>

        <div class="filter-section">
            <h3>🔍 Selecione o Período</h3>
            <form action="controller" method="post" class="filter-form" id="reportForm">
                <input type="hidden" name="handler" value="ShowProvision">
                
                <div class="form-group">
                    <label for="start_date">Data Inicial</label>
                    <input type="date" id="start_date" name="start_date" 
                           value="${start_date}" class="date-input" required>
                </div>
                
                <div class="form-group">
                    <label for="end_date">Data Final</label>
                    <input type="date" id="end_date" name="end_date" 
                           value="${end_date}" class="date-input" required>
                </div>
                
                <button type="submit" class="filter-btn">🔍 Gerar Relatório</button>
            </form>
        </div>

        <c:if test="${not empty provisions}">
            <div class="period-info">
                <p>📅 Período: ${start_date} até ${end_date}</p>
            </div>

            <div class="summary-cards">
                <div class="summary-card">
                    <h4>Total de Prestações</h4>
                    <div class="summary-value">${provisions.size()}</div>
                </div>

                <div class="summary-card">
                    <h4>Faturamento Total</h4>
                    <div class="summary-value">
                        R$ <fmt:formatNumber value="${total_revenue}" pattern="#,##0.00"/>
                    </div>
                </div>

                <div class="summary-card">
                    <h4>Ticket Médio</h4>
                    <div class="summary-value">
                        R$ <fmt:formatNumber value="${total_revenue / provisions.size()}" pattern="#,##0.00"/>
                    </div>
                </div>
            </div>

            <div class="table-container" style="margin-top: 30px;">
                <div class="table-header">
                    <h3>Prestações no Período</h3>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Data</th>
                            <th>Cão</th>
                            <th>Serviços</th>
                            <th>Desconto</th>
                            <th>Valor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="provision" items="${provisions}">
                            <tr>
                                <td><strong>#${provision.id}</strong></td>
                                <td>
                                    <fmt:formatDate value="${provision.date}" pattern="dd/MM/yyyy"/>
                                </td>
                                <td>${provision.dog.name}</td>
                                <td style="font-size: 0.9em;">
                                    <c:forEach var="service" items="${provision.servicesList}" varStatus="status">
                                        ${service.name}<c:if test="${!status.last}">, </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:if test="${provision.discount}">
                                        <span class="discount-badge">✓ 10% OFF</span>
                                    </c:if>
                                </td>
                                <td class="price-value">
                                    R$ <fmt:formatNumber value="${provision.amountCharged}" pattern="#,##0.00"/>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <tr class="total-row">
                            <td colspan="5" style="text-align: right; padding-right: 30px;">
                                💰 TOTAL FATURADO:
                            </td>
                            <td>
                                R$ <fmt:formatNumber value="${total_revenue}" pattern="#,##0.00"/>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </c:if>

        <c:if test="${empty provisions && not empty start_date}">
            <div class="table-container">
                <div class="empty-state">
                    <div class="empty-state-icon">📊</div>
                    <h3>Nenhuma prestação encontrada</h3>
                    <p>Não há prestações de serviço no período selecionado</p>
                </div>
            </div>
        </c:if>
    </div>

    <script>
        // Validação de datas
        const startDateInput = document.getElementById('start_date');
        const endDateInput = document.getElementById('end_date');

        endDateInput.addEventListener('change', function() {
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(this.value);

            if(endDate < startDate) {
                alert('A data final não pode ser anterior à data inicial!');
                this.value = startDateInput.value;
            }
        });

        document.getElementById('reportForm').addEventListener('submit', function(e) {
            const startDate = startDateInput.value;
            const endDate = endDateInput.value;

            if(!startDate || !endDate) {
                e.preventDefault();
                alert('Por favor, preencha ambas as datas.');
            }
        });
    </script>
</body>
</html>