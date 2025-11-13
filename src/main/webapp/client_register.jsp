<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
   
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Cadastrar Cliente</title>
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

        /* FORMULÁRIO */
        .form-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            max-width: 700px;
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

        .success-message {
            color: #2A9D8F;
            font-size: 0.85em;
            margin-top: 6px;
            display: none;
            align-items: center;
            gap: 5px;
        }

        .success-message.show {
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

        .alert.success {
            background: #f0fdf4;
            border: 2px solid #2A9D8F;
            color: #2A9D8F;
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
            <li><a href="client_home.jsp" class="active">👥 <span>Clientes</span></a></li>
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
            <h2>➕ Cadastrar Cliente</h2>
            <a href="client_home.jsp" class="back-btn">← Voltar</a>
        </div>

        <div class="form-container">
            <div id="alertBox" class="alert"></div>

            <form id="clientForm" action="controller" method="post" novalidate>
                <div class="form-group">
                    <label for="cpf">CPF <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="text" id="cpf" name="cpf" maxlength="14" required>
                    </div>
                    <div class="error-message" id="cpfError">
                        ⚠️ <span>CPF inválido</span>
                    </div>
                    <div class="helper-text">Formato: 000.000.000-00</div>
                </div>

                <div class="form-group">
                    <label for="name">Nome Completo <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="error-message" id="nameError">
                        ⚠️ <span>Nome deve ter pelo menos 3 caracteres</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">E-mail <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="error-message" id="emailError">
                        ⚠️ <span>E-mail inválido</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="telephone">Telefone <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="text" id="telephone" name="telephone" maxlength="15" required>
                    </div>
                    <div class="error-message" id="telephoneError">
                        ⚠️ <span>Telefone inválido</span>
                    </div>
                    <div class="helper-text">Formato: (00) 00000-0000</div>
                </div>

                <div class="form-group">
                    <label for="birth_date">Data de Nascimento <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="text" id="birth_date" name="birth_date" maxlength="10" required>
                    </div>
                    <div class="error-message" id="birthDateError">
                        ⚠️ <span>Data inválida</span>
                    </div>
                    <div class="helper-text">Formato: DD/MM/AAAA</div>
                </div>

                <input type="hidden" name="handler" value="RegisterClient">

                <div class="form-actions">
                    <button type="submit" class="submit-btn">✅ Cadastrar Cliente</button>
                    <a href="client_home.jsp" class="cancel-btn">❌ Cancelar</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Máscaras de input
        const cpfInput = document.getElementById('cpf');
        const telephoneInput = document.getElementById('telephone');
        const birthDateInput = document.getElementById('birth_date');

        // Máscara CPF
        cpfInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if(value.length <= 11) {
                value = value.replace(/(\d{3})(\d)/, '$1.$2');
                value = value.replace(/(\d{3})(\d)/, '$1.$2');
                value = value.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
                e.target.value = value;
            }
        });

        // Máscara Telefone
        telephoneInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if(value.length <= 11) {
                value = value.replace(/(\d{2})(\d)/, '($1) $2');
                value = value.replace(/(\d{5})(\d)/, '$1-$2');
                e.target.value = value;
            }
        });

        // Máscara Data
        birthDateInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if(value.length <= 8) {
                value = value.replace(/(\d{2})(\d)/, '$1/$2');
                value = value.replace(/(\d{2})(\d)/, '$1/$2');
                e.target.value = value;
            }
        });

        // Validações
        function validateCPF(cpf) {
            cpf = cpf.replace(/\D/g, '');
            if(cpf.length !== 11 || /^(\d)\1{10}$/.test(cpf)) return false;

            let sum = 0;
            for(let i = 0; i < 9; i++) {
                sum += parseInt(cpf.charAt(i)) * (10 - i);
            }
            let digit1 = 11 - (sum % 11);
            if(digit1 >= 10) digit1 = 0;

            sum = 0;
            for(let i = 0; i < 10; i++) {
                sum += parseInt(cpf.charAt(i)) * (11 - i);
            }
            let digit2 = 11 - (sum % 11);
            if(digit2 >= 10) digit2 = 0;

            return (parseInt(cpf.charAt(9)) === digit1 && parseInt(cpf.charAt(10)) === digit2);
        }

        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }

        function validateDate(date) {
            const parts = date.split('/');
            if(parts.length !== 3) return false;

            const day = parseInt(parts[0], 10);
            const month = parseInt(parts[1], 10);
            const year = parseInt(parts[2], 10);

            if(year < 1900 || year > new Date().getFullYear()) return false;
            if(month < 1 || month > 12) return false;
            if(day < 1 || day > 31) return false;

            const dateObj = new Date(year, month - 1, day);
            return dateObj.getDate() === day && dateObj.getMonth() === month - 1 && dateObj.getFullYear() === year;
        }

        function validatePhone(phone) {
            const cleaned = phone.replace(/\D/g, '');
            return cleaned.length === 10 || cleaned.length === 11;
        }

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
        cpfInput.addEventListener('blur', function() {
            const cpfError = document.getElementById('cpfError');
            if(!validateCPF(this.value)) {
                showError(this, cpfError, 'CPF inválido');
            } else {
                showSuccess(this, cpfError);
            }
        });

        document.getElementById('name').addEventListener('blur', function() {
            const nameError = document.getElementById('nameError');
            if(this.value.trim().length < 3) {
                showError(this, nameError, 'Nome deve ter pelo menos 3 caracteres');
            } else {
                showSuccess(this, nameError);
            }
        });

        document.getElementById('email').addEventListener('blur', function() {
            const emailError = document.getElementById('emailError');
            if(!validateEmail(this.value)) {
                showError(this, emailError, 'E-mail inválido');
            } else {
                showSuccess(this, emailError);
            }
        });

        telephoneInput.addEventListener('blur', function() {
            const telephoneError = document.getElementById('telephoneError');
            if(!validatePhone(this.value)) {
                showError(this, telephoneError, 'Telefone deve ter 10 ou 11 dígitos');
            } else {
                showSuccess(this, telephoneError);
            }
        });

        birthDateInput.addEventListener('blur', function() {
            const birthDateError = document.getElementById('birthDateError');
            if(!validateDate(this.value)) {
                showError(this, birthDateError, 'Data inválida. Use DD/MM/AAAA');
            } else {
                showSuccess(this, birthDateError);
            }
        });

        // Validação no submit
        document.getElementById('clientForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const cpf = cpfInput.value;
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const telephone = telephoneInput.value;
            const birthDate = birthDateInput.value;

            let isValid = true;

            if(!validateCPF(cpf)) {
                showError(cpfInput, document.getElementById('cpfError'), 'CPF inválido');
                isValid = false;
            }

            if(name.trim().length < 3) {
                showError(document.getElementById('name'), document.getElementById('nameError'), 'Nome deve ter pelo menos 3 caracteres');
                isValid = false;
            }

            if(!validateEmail(email)) {
                showError(document.getElementById('email'), document.getElementById('emailError'), 'E-mail inválido');
                isValid = false;
            }

            if(!validatePhone(telephone)) {
                showError(telephoneInput, document.getElementById('telephoneError'), 'Telefone inválido');
                isValid = false;
            }

            if(!validateDate(birthDate)) {
                showError(birthDateInput, document.getElementById('birthDateError'), 'Data inválida');
                isValid = false;
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

        // Verifica mensagem de sucesso/erro do servidor
        <% if(request.getParameter("success") != null) { %>
            showAlert('Cliente cadastrado com sucesso!', 'success');
        <% } else if(request.getParameter("error") != null) { %>
            showAlert('Erro ao cadastrar cliente. Tente novamente.', 'error');
        <% } %>
    </script>
</body>
</html>