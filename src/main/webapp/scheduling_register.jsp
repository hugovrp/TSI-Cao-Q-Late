<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Novo Agendamento</title>
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
            max-width: 800px;
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

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
        }

        .service-checkbox {
            position: relative;
        }

        .service-checkbox input[type="checkbox"] {
            display: none;
        }

        .service-label {
            display: flex;
            flex-direction: column;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #F4F4F4;
        }

        .service-checkbox input[type="checkbox"]:checked + .service-label {
            border-color: #2A9D8F;
            background: linear-gradient(135deg, rgba(42, 157, 143, 0.1), rgba(42, 157, 143, 0.05));
        }

        .service-label:hover {
            border-color: #2A9D8F;
        }

        .service-name {
            font-weight: 600;
            color: #264653;
            margin-bottom: 5px;
        }

        .service-price {
            color: #2A9D8F;
            font-weight: 600;
            font-size: 1.1em;
        }

        .service-checkbox input[type="checkbox"]:checked + .service-label .service-name::before {
            content: '✓ ';
            color: #2A9D8F;
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

        .submit-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
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

        .helper-text {
            color: #666;
            font-size: 0.85em;
            margin-top: 5px;
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

            .services-grid {
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
            <h2>➕ Novo Agendamento</h2>
            <a href="scheduling_home.jsp" class="back-btn">← Voltar</a>
        </div>

        <div class="form-container">
            <div id="alertBox" class="alert"></div>

            <form id="schedulingForm" action="controller" method="post" novalidate>
                <div class="form-group">
                    <label for="client_id">ID do Cliente <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="number" id="client_id" name="client_id" min="1" required>
                    </div>
                    <div class="error-message" id="clientError">
                        ⚠️ <span>ID do cliente deve ser um número válido</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="dog_id">ID do Cão <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="number" id="dog_id" name="dog_id" min="1" required>
                    </div>
                    <div class="error-message" id="dogError">
                        ⚠️ <span>ID do cão deve ser um número válido</span>
                    </div>
                    <div class="helper-text">O cão deve pertencer ao cliente informado</div>
                </div>

                <div class="form-group">
                    <label for="date">Data do Agendamento <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="date" id="date" name="date" required>
                    </div>
                    <div class="error-message" id="dateError">
                        ⚠️ <span>Data inválida</span>
                    </div>
                    <div class="helper-text">A data deve ser igual ou posterior a hoje</div>
                </div>

                <div class="form-group">
                    <label>Serviços <span class="required">*</span></label>
                    <div class="services-grid">
                        <c:forEach var="s" items="${services}">
                            <div class="service-checkbox">
                                <input type="checkbox" id="service_${s.id}" name="services_id" value="${s.id}">
                                <label for="service_${s.id}" class="service-label">
                                    <span class="service-name">${s.name}</span>
                                    <span class="service-price">R$ <fmt:formatNumber value="${s.price}" pattern="#,##0.00"/></span>
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="error-message" id="servicesError">
                        ⚠️ <span>Selecione pelo menos um serviço</span>
                    </div>
                </div>

                <input type="hidden" name="handler" value="RegisterScheduling">

                <div class="form-actions">
                    <button type="submit" class="submit-btn">✅ Confirmar Agendamento</button>
                    <a href="scheduling_home.jsp" class="cancel-btn">❌ Cancelar</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        const clientInput = document.getElementById('client_id');
        const dogInput = document.getElementById('dog_id');
        const dateInput = document.getElementById('date');

        // Definir data mínima como hoje
        const today = new Date().toISOString().split('T')[0];
        dateInput.setAttribute('min', today);

        function showError(input, errorElement, message) {
            if(input) {
                input.classList.add('error');
                input.classList.remove('success');
            }
            errorElement.querySelector('span').textContent = message;
            errorElement.classList.add('show');
        }

        function showSuccess(input, errorElement) {
            if(input) {
                input.classList.remove('error');
                input.classList.add('success');
            }
            errorElement.classList.remove('show');
        }

        // Validação em tempo real
        clientInput.addEventListener('blur', function() {
            const clientError = document.getElementById('clientError');
            if(!this.value || this.value < 1) {
                showError(this, clientError, 'ID do cliente deve ser um número válido');
            } else {
                showSuccess(this, clientError);
            }
        });

        dogInput.addEventListener('blur', function() {
            const dogError = document.getElementById('dogError');
            if(!this.value || this.value < 1) {
                showError(this, dogError, 'ID do cão deve ser um número válido');
            } else {
                showSuccess(this, dogError);
            }
        });

        dateInput.addEventListener('blur', function() {
            const dateError = document.getElementById('dateError');
            const selectedDate = new Date(this.value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            if(!this.value) {
                showError(this, dateError, 'Por favor, selecione uma data');
            } else if(selectedDate < today) {
                showError(this, dateError, 'A data não pode ser no passado');
            } else {
                showSuccess(this, dateError);
            }
        });

        // Validação no submit
        document.getElementById('schedulingForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const clientId = clientInput.value;
            const dogId = dogInput.value;
            const date = dateInput.value;
            const selectedServices = document.querySelectorAll('input[name="services_id"]:checked');

            let isValid = true;

            // Valida cliente
            if(!clientId || clientId < 1) {
                showError(clientInput, document.getElementById('clientError'), 'ID do cliente deve ser um número válido');
                isValid = false;
            }

            // Valida cão
            if(!dogId || dogId < 1) {
                showError(dogInput, document.getElementById('dogError'), 'ID do cão deve ser um número válido');
                isValid = false;
            }

            // Valida data
            const selectedDate = new Date(date);
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            if(!date) {
                showError(dateInput, document.getElementById('dateError'), 'Por favor, selecione uma data');
                isValid = false;
            } else if(selectedDate < today) {
                showError(dateInput, document.getElementById('dateError'), 'A data não pode ser no passado');
                isValid = false;
            }

            // Valida serviços
            if(selectedServices.length === 0) {
                showError(null, document.getElementById('servicesError'), 'Selecione pelo menos um serviço');
                isValid = false;
            } else {
                document.getElementById('servicesError').classList.remove('show');
            }

            if(isValid) {
                this.submit();
            } else {
                showAlert('Por favor, corrija os erros no formulário', 'error');
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

        // Verifica mensagem de erro do servidor
        <c:if test="${not empty error}">
            showAlert('${error}', 'error');
        </c:if>
    </script>
</body>
</html>