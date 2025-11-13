<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Dashboard</title>
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

        /* SIDEBAR */
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
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .sidebar-header p {
            font-size: 0.85em;
            opacity: 0.7;
            margin-top: 5px;
        }

        .user-info {
            background: rgba(42, 157, 143, 0.2);
            padding: 15px;
            border-radius: 10px;
            margin: 0 25px 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            background: #2A9D8F;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
        }

        .user-details h3 {
            font-size: 0.95em;
            font-weight: 600;
        }

        .user-details p {
            font-size: 0.8em;
            opacity: 0.7;
            margin-top: 2px;
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

        /* MAIN CONTENT */
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

        .date-time {
            color: #666;
            font-size: 0.95em;
        }

        /* CARDS DE ESTATÍSTICAS */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .stat-info h3 {
            color: #666;
            font-size: 0.9em;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .stat-info .number {
            font-size: 2em;
            font-weight: 700;
            color: #264653;
        }

        .stat-info .trend {
            font-size: 0.85em;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .trend.up {
            color: #2A9D8F;
        }

        .trend.down {
            color: #e74c3c;
        }

        .stat-icon {
            width: 70px;
            height: 70px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
        }

        .stat-card:nth-child(1) .stat-icon {
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
        }

        .stat-card:nth-child(2) .stat-icon {
            background: linear-gradient(135deg, #E9C46A, #d4a849);
        }

        .stat-card:nth-child(3) .stat-icon {
            background: linear-gradient(135deg, #264653, #1a3540);
        }

        .stat-card:nth-child(4) .stat-icon {
            background: linear-gradient(135deg, #f4a261, #e76f51);
        }

        /* SEÇÃO DE CONTEÚDO */
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #F4F4F4;
        }

        .card-header h3 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            font-size: 1.3em;
        }

        .card-header a {
            color: #2A9D8F;
            text-decoration: none;
            font-size: 0.9em;
            font-weight: 500;
            transition: color 0.3s;
        }

        .card-header a:hover {
            color: #264653;
        }

        /* AGENDAMENTOS */
        .appointment-item {
            padding: 15px;
            border-left: 4px solid #2A9D8F;
            background: #f8f9fa;
            border-radius: 8px;
            margin-bottom: 12px;
            transition: all 0.3s ease;
        }

        .appointment-item:hover {
            background: #e9ecef;
            transform: translateX(5px);
        }

        .appointment-time {
            font-weight: 600;
            color: #2A9D8F;
            font-size: 0.9em;
            margin-bottom: 5px;
        }

        .appointment-details {
            color: #333;
            font-size: 0.95em;
        }

        .appointment-service {
            color: #666;
            font-size: 0.85em;
            margin-top: 3px;
        }

        /* ATIVIDADES RECENTES */
        .activity-item {
            display: flex;
            gap: 15px;
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2em;
            flex-shrink: 0;
        }

        .activity-icon.new {
            background: #e8f5e9;
        }

        .activity-icon.update {
            background: #fff3e0;
        }

        .activity-icon.complete {
            background: #e3f2fd;
        }

        .activity-details h4 {
            color: #333;
            font-size: 0.95em;
            font-weight: 600;
            margin-bottom: 3px;
        }

        .activity-details p {
            color: #666;
            font-size: 0.85em;
        }

        .activity-time {
            color: #999;
            font-size: 0.8em;
            margin-top: 5px;
        }

        /* AÇÕES RÁPIDAS */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .quick-action-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
            color: white;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.3s ease;
            gap: 10px;
        }

        .quick-action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(42, 157, 143, 0.3);
        }

        .quick-action-btn .icon {
            font-size: 2em;
        }

        .quick-action-btn .text {
            font-size: 0.9em;
            font-weight: 600;
        }

        /* RESPONSIVO */
        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }

            .sidebar-header h1,
            .sidebar-header p,
            .user-info,
            .sidebar a span,
            .sidebar-footer {
                display: none;
            }

            .main-content {
                margin-left: 70px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h1>🐕 Cão Q-Late</h1>
            <p>Sistema de Gerenciamento</p>
        </div>

        <div class="user-info">
            <div class="user-avatar">👤</div>
            <div class="user-details">
                <h3>${sessionScope.name}</h3>
                <p>Administrador</p>
            </div>
        </div>

        <ul>
            <li><a href="index.jsp" class="active">📊 <span>Dashboard</span></a></li>
            <li><a href="client_home.jsp">👥 <span>Clientes</span></a></li>
            <li><a href="dog_home.jsp">🐶 <span>Cães</span></a></li>
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
            <h2>Dashboard</h2>
            <div class="date-time" id="dateTime"></div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Agendamentos Hoje</h3>
                    <div class="number">--</div>
                </div>
                <div class="stat-icon">📅</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Clientes Ativos</h3>
                    <div class="number">--</div>
                </div>
                <div class="stat-icon">👥</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Cães Cadastrados</h3>
                    <div class="number">--</div>
                </div>
                <div class="stat-icon">🐶</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Serviços Prestados</h3>
                    <div class="number">--</div>
                </div>
                <div class="stat-icon">✂️</div>
            </div>
        </div>

        <div class="content-grid">
            <div class="card">
                <div class="card-header">
                    <h3>📅 Próximos Agendamentos</h3>
                    <a href="scheduling_home.jsp">Ver todos →</a>
                </div>

                <div style="text-align: center; padding: 40px 20px; color: #999;">
                    <div style="font-size: 3em; margin-bottom: 15px;">📅</div>
                    <p>Nenhum agendamento para hoje</p>
                    <a href="scheduling_home.jsp" style="color: #2A9D8F; text-decoration: none; font-weight: 500; margin-top: 10px; display: inline-block;">Criar novo agendamento</a>
                </div>
            </div>

            <div>
                <div class="card" style="margin-bottom: 25px;">
                    <div class="card-header">
                        <h3>⚡ Ações Rápidas</h3>
                    </div>

                    <div class="quick-actions">
                        <a href="scheduling_home.jsp" class="quick-action-btn">
                            <div class="icon">➕</div>
                            <div class="text">Novo Agendamento</div>
                        </a>
                        <a href="client_home.jsp" class="quick-action-btn" style="background: linear-gradient(135deg, #E9C46A, #d4a849);">
                            <div class="icon">👤</div>
                            <div class="text">Novo Cliente</div>
                        </a>
                        <a href="dog_home.jsp" class="quick-action-btn" style="background: linear-gradient(135deg, #264653, #1a3540);">
                            <div class="icon">🐕</div>
                            <div class="text">Novo Cão</div>
                        </a>
                        <a href="service_provision_home.jsp" class="quick-action-btn" style="background: linear-gradient(135deg, #f4a261, #e76f51);">
                            <div class="icon">✅</div>
                            <div class="text">Prestar Serviço</div>
                        </a>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h3>🔔 Atividades Recentes</h3>
                    </div>

                    <div style="text-align: center; padding: 40px 20px; color: #999;">
                        <div style="font-size: 3em; margin-bottom: 15px;">🔔</div>
                        <p>Nenhuma atividade recente</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Atualiza data e hora
        function updateDateTime() {
            const now = new Date();
            const options = { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            };
            document.getElementById('dateTime').textContent = now.toLocaleDateString('pt-BR', options);
        }

        updateDateTime();
        setInterval(updateDateTime, 60000); // Atualiza a cada minuto
    </script>
</body>
</html>