<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
   
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Buscar Serviço</title>
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

        .form-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            max-width: 700px;
        }

        .info-box {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            color: #1565c0;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }

        .info-box .icon {
            font-size: 1.5em;
            flex-shrink: 0;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95em;
        }

        .form-group label .required {
            color: #e74c3c;
            margin-left: 3px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper input {
            width: 100%;
            padding: 14px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
            background: #F4F4F4;
        }

        .input-wrapper input:focus {
            outline: none;
            border-color: #2A9D8F;
            background: white;
        }

        .input-wrapper input.error {
            border-color: #e74c3c;
            background: #fff5f5;
        }

        .input-wrapper input.success {
            border-color: #2A9D8F;
        }

        .error-message {
            color: #e74c3c;
            font-size: 0.85em;
            margin-top: 6px;
            display: none;
            align-items: center;
            gap: 5px;
        }

        .error-message.show {
            display: flex;
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

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .submit-btn {
            flex: 1;
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 10px;
            font-size: 1.05em;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(42, 157, 143, 0.3);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(42, 157, 143, 0.4);
        }

        .cancel-btn {
            padding: 15px 30px;
            background: #f4f4f4;
            color: #264653;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1.05em;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .cancel-btn:hover {
            background: #264653;
            color: white;
            border-color: #264653;
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

            .form-actions {
                flex-direction: column;
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
            <li><a href="service_home.jsp" class="active">✂️ <span>Serviços</span></a></li>
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
            <h2>🔍 Buscar Serviço para Alterar</h2>
            <a href="service_home.jsp" class="back-btn">← Voltar</a>
        </div>

        <div class="form-container">
            <div class="info-box">
                <span class="icon">💡</span>
                <div>
                    <strong>Dica:</strong> Você pode encontrar o ID do serviço na lista de serviços da página anterior.
                </div>
            </div>

            <div id="alertBox" class="alert"></div>

            <form id="searchForm" action="controller" method="post" novalidate>
                <div class="form-group">
                    <label for="id">ID do Serviço <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="number" id="id" name="id" min="1" required>
                    </div>
                    <div class="error-message" id="idError">
                        ⚠️ <span>ID deve ser um número válido</span>
                    </div>
                </div>

                <input type="hidden" name="handler" value="SearchService">

                <div class="form-actions">
                    <button type="submit" class="submit-btn">🔍 Buscar Serviço</button>
                    <a href="service_home.jsp" class="cancel-btn">❌ Cancelar</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        const idInput = document.getElementById('id');

        function showError(input, errorElement, message) {
            input.classList.add('error');
            input.classList.remove('success');
            errorElement.querySelector('span').textContent = message;
            errorElement.classList.add('show');
        }

        function showSuccess(input, errorElement) {
            input.classList.remove('error');
            input.classList.add('success');
            errorElement.classList.remove('show');
        }

        // Validação em tempo real
        idInput.addEventListener('blur', function() {
            const idError = document.getElementById('idError');
            if(!this.value || this.value < 1) {
                showError(this, idError, 'ID deve ser um número válido');
            } else {
                showSuccess(this, idError);
            }
        });

        // Validação no submit
        document.getElementById('searchForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const id = idInput.value;
            let isValid = true;

            if(!id || id < 1) {
                showError(idInput, document.getElementById('idError'), 'ID deve ser um número válido');
                isValid = false;
            }

            if(isValid) {
                this.submit();
            } else {
                showAlert('Por favor, informe um ID válido', 'error');
            }
        });

        function showAlert(message, type) {
            const alertBox = document.getElementById('alertBox');
            alertBox.textContent = (type === 'error' ? '❌ ' : '✅ ') + message;
            alertBox.className = 'alert ' + type + ' show';

            setTimeout(() => {
                alertBox.classList.remove('show');
            }, 5000);
        }
    </script>
</body>
</html>