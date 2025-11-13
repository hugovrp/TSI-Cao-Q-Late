<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
   
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

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }

        .action-card {
            background: white;
            padding: 0;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .action-card form {
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .action-content {
            padding: 35px 25px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            flex: 1;
        }

        .action-icon {
            width: 75px;
            height: 75px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.3em;
            margin-bottom: 18px;
        }

        .action-card:nth-child(1) .action-icon {
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
        }

        .action-card:nth-child(2) .action-icon {
            background: linear-gradient(135deg, #264653, #1a3540);
        }

        .action-card h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            font-size: 1.3em;
            margin-bottom: 10px;
        }

        .action-card p {
            color: #666;
            font-size: 0.9em;
            line-height: 1.5;
        }

        .action-btn {
            width: 100%;
            padding: 18px;
            background: #F4F4F4;
            border: none;
            font-size: 1em;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            color: #264653;
        }

        .action-card:nth-child(1) .action-btn:hover {
            background: #2A9D8F;
            color: white;
        }

        .action-card:nth-child(2) .action-btn:hover {
            background: #264653;
            color: white;
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

            .actions-grid {
                grid-template-columns: 1fr;
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
            <h2>📅 Gerenciar Agendamentos</h2>
            <a href="index.jsp" class="back-btn">← Voltar ao Dashboard</a>
        </div>

        <div id="alertBox" class="alert"></div>

        <div class="actions-grid">
            <div class="action-card">
                <form action="controller" method="post">
                    <div class="action-content">
                        <div class="action-icon">➕</div>
                        <h3>Novo Agendamento</h3>
                        <p>Agende serviços para um cão</p>
                    </div>
                    <input type="hidden" name="handler" value="ShowScheduling">
                    <button type="submit" class="action-btn">Agendar Serviço</button>
                </form>
            </div>

            <div class="action-card">
                <form action="controller" method="post">
                    <div class="action-content">
                        <div class="action-icon">📋</div>
                        <h3>Ver Agendamentos</h3>
                        <p>Consulte e gerencie agendamentos</p>
                    </div>
                    <input type="hidden" name="handler" value="ShowListScheduling">
                    <button type="submit" class="action-btn">Listar Agendamentos</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showAlert(message, type) {
            const alertBox = document.getElementById('alertBox');
            alertBox.textContent = (type === 'error' ? '❌ ' : '✅ ') + message;
            alertBox.className = 'alert ' + type + ' show';

            setTimeout(() => {
                alertBox.classList.remove('show');
            }, 5000);
        }

        // Verifica mensagens do servidor
        <% if(request.getAttribute("successMessage") != null) { %>
            showAlert('<%= request.getAttribute("successMessage") %>', 'success');
        <% } else if(request.getAttribute("errorMessage") != null) { %>
            showAlert('<%= request.getAttribute("errorMessage") %>', 'error');
        <% } %>
    </script>
</body>
</html>