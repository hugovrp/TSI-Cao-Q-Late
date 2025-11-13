<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Alterar Preço</title>
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

        .service-info-card {
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
            color: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .service-info-card h3 {
            font-family: 'Poppins', sans-serif;
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .service-info-card .current-price {
            font-size: 1.8em;
            font-weight: 700;
            margin-top: 10px;
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

        .input-wrapper input:disabled {
            background: #e9ecef;
            color: #6c757d;
            cursor: not-allowed;
        }

        .input-wrapper input.error {
            border-color: #e74c3c;
            background: #fff5f5;
        }

        .input-wrapper input.success {
            border-color: #2A9D8F;
        }

        .currency-symbol {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-weight: 600;
        }

        .input-wrapper input.currency-input {
            padding-left: 45px;
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

        .helper-text {
            color: #666;
            font-size: 0.85em;
            margin-top: 5px;
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
            <h2>✏️ Alterar Preço do Serviço</h2>
            <a href="service_home.jsp" class="back-btn">← Voltar</a>
        </div>

        <div class="form-container">
            <div class="service-info-card">
                <h3>✂️ ${requestScope.service.name}</h3>
                <div>ID: #${requestScope.service.id}</div>
                <div class="current-price">
                    Preço Atual: R$ <fmt:formatNumber value="${requestScope.service.price}" pattern="#,##0.00"/>
                </div>
            </div>

            <div id="alertBox" class="alert"></div>

            <form id="changeForm" action="controller" method="post" novalidate>
                <input type="hidden" name="id" value="${requestScope.service.id}">
                <input type="hidden" name="name" value="${requestScope.service.name}">

                <div class="form-group">
                    <label>ID do Serviço</label>
                    <div class="input-wrapper">
                        <input type="text" value="#${requestScope.service.id}" disabled>
                    </div>
                </div>

                <div class="form-group">
                    <label>Nome do Serviço</label>
                    <div class="input-wrapper">
                        <input type="text" value="${requestScope.service.name}" disabled>
                    </div>
                </div>

                <div class="form-group">
                    <label for="price">Novo Preço <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <span class="currency-symbol">R$</span>
                        <input type="text" id="price" name="price" class="currency-input" 
                               value="<fmt:formatNumber value="${requestScope.service.price}" pattern="0.00"/>" required>
                    </div>
                    <div class="error-message" id="priceError">
                        ⚠️ <span>Preço deve ser maior que R$ 0,00</span>
                    </div>
                    <div class="helper-text">Use vírgula para centavos (ex: 50,00)</div>
                </div>

                <input type="hidden" name="handler" value="ChangeService">

                <div class="form-actions">
                    <button type="submit" class="submit-btn">✅ Alterar Preço</button>
                    <a href="service_home.jsp" class="cancel-btn">❌ Cancelar</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        const priceInput = document.getElementById('price');

        // Converte ponto para vírgula na inicialização
        window.addEventListener('DOMContentLoaded', function() {
            priceInput.value = priceInput.value.replace('.', ',');
        });

        // Máscara de preço (formato brasileiro)
        priceInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            
            if(value.length === 0) {
                e.target.value = '';
                return;
            }
            
            value = value.padStart(3, '0');
            const intPart = value.slice(0, -2);
            const decPart = value.slice(-2);
            const cleanIntPart = intPart.replace(/^0+/, '') || '0';
            
            e.target.value = cleanIntPart + ',' + decPart;
        });

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

        function parsePrice(priceStr) {
            return parseFloat(priceStr.replace(',', '.'));
        }

        // Validação em tempo real
        priceInput.addEventListener('blur', function() {
            const priceError = document.getElementById('priceError');
            const price = parsePrice(this.value);
            
            if(isNaN(price) || price <= 0) {
                showError(this, priceError, 'Preço deve ser maior que R$ 0,00');
            } else if(price > 9999.99) {
                showError(this, priceError, 'Preço máximo: R$ 9.999,99');
            } else {
                showSuccess(this, priceError);
            }
        });

        // Validação no submit
        document.getElementById('changeForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const priceStr = priceInput.value;
            const price = parsePrice(priceStr);

            let isValid = true;

            if(isNaN(price) || price <= 0) {
                showError(priceInput, document.getElementById('priceError'), 'Preço deve ser maior que R$ 0,00');
                isValid = false;
            } else if(price > 9999.99) {
                showError(priceInput, document.getElementById('priceError'), 'Preço máximo: R$ 9.999,99');
                isValid = false;
            }

            if(isValid) {
                // Converte vírgula para ponto antes de enviar
                const hiddenPrice = document.createElement('input');
                hiddenPrice.type = 'hidden';
                hiddenPrice.name = 'price';
                hiddenPrice.value = price.toString();
                
                priceInput.disabled = true;
                this.appendChild(hiddenPrice);
                
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
    </script>
</body>
</html>