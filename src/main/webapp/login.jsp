<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cão Q-Late - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&family=Inter:wght@400;500&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #2A9D8F 0%, #264653 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            display: flex;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
        }

        .login-image {
            flex: 1;
            background: linear-gradient(rgba(42, 157, 143, 0.9), rgba(38, 70, 83, 0.9)),
                        url('https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=800') center/cover;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px;
            color: white;
            position: relative;
        }

        .login-image::before {
            content: '🐕';
            font-size: 80px;
            margin-bottom: 20px;
        }

        .login-image h1 {
            font-family: 'Poppins', sans-serif;
            font-size: 2.5em;
            margin-bottom: 10px;
            text-align: center;
        }

        .login-image p {
            font-size: 1.1em;
            text-align: center;
            opacity: 0.9;
        }

        .login-form {
            flex: 1;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header {
            margin-bottom: 40px;
        }

        .form-header h2 {
            font-family: 'Poppins', sans-serif;
            color: #264653;
            font-size: 2em;
            margin-bottom: 10px;
        }

        .form-header p {
            color: #666;
            font-size: 0.95em;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 0.95em;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper input {
            width: 100%;
            padding: 14px 45px 14px 15px;
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

        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2em;
            color: #999;
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

        .forgot-password {
            text-align: right;
            margin-bottom: 25px;
        }

        .forgot-password a {
            color: #2A9D8F;
            text-decoration: none;
            font-size: 0.9em;
            transition: color 0.3s;
        }

        .forgot-password a:hover {
            color: #264653;
        }

        .submit-btn {
            background: linear-gradient(135deg, #2A9D8F, #1a7d71);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 10px;
            font-size: 1.1em;
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

        .submit-btn:active {
            transform: translateY(0);
        }

        .submit-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
            align-items: center;
            gap: 10px;
            font-size: 0.9em;
        }

        .alert.show {
            display: flex;
        }

        .alert.error {
            background: #fff5f5;
            border: 1px solid #e74c3c;
            color: #e74c3c;
        }

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }

            .login-image {
                padding: 40px 20px;
            }

            .login-image h1 {
                font-size: 2em;
            }

            .login-form {
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-image">
            <h1>Cão Q-Late</h1>
            <p>Sistema de Gerenciamento do Petshop</p>
        </div>

        <div class="login-form">
            <div class="form-header">
                <h2>Bem-vindo!</h2>
                <p>Faça login para gerenciar seu petshop</p>
            </div>

            <div id="alertBox" class="alert"></div>

            <form id="loginForm" action="controller" method="post" novalidate>
                <div class="form-group">
                    <label for="login">Login</label>
                    <div class="input-wrapper">
                        <input type="text" id="login" name="login" required>
                        <span class="input-icon">👤</span>
                    </div>
                    <div class="error-message" id="loginError">
                        ⚠️ <span>Por favor, insira seu login</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Senha</label>
                    <div class="input-wrapper">
                        <input type="password" id="password" name="password" required>
                        <span class="input-icon">🔒</span>
                    </div>
                    <div class="error-message" id="passwordError">
                        ⚠️ <span>Por favor, insira sua senha</span>
                    </div>
                </div>

                <div class="forgot-password">
                    <a href="#">Esqueceu a senha?</a>
                </div>

                <input type="hidden" name="handler" value="Login">
                <input type="hidden" id="hashedPassword" name="hashedPassword">
                
                <button type="submit" class="submit-btn">Entrar</button>
            </form>
        </div>
    </div>

    <script>
        const loginForm = document.getElementById('loginForm');
        const loginInput = document.getElementById('login');
        const passwordInput = document.getElementById('password');
        const loginError = document.getElementById('loginError');
        const passwordError = document.getElementById('passwordError');
        const alertBox = document.getElementById('alertBox');
        const hashedPasswordInput = document.getElementById('hashedPassword');

        // Função para hash 
        async function hashPassword(password) {
            const encoder = new TextEncoder();
            const data = encoder.encode(password);
            const hashBuffer = await crypto.subtle.digest('SHA-256', data);
            const hashArray = Array.from(new Uint8Array(hashBuffer));
            const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
            return hashHex;
        }

        // Validação em tempo real
        loginInput.addEventListener('input', function() {
            if(this.value.trim() !== '') {
                this.classList.remove('error');
                this.classList.add('success');
                loginError.classList.remove('show');
            }
        });

        passwordInput.addEventListener('input', function() {
            if(this.value.length >= 4) {
                this.classList.remove('error');
                this.classList.add('success');
                passwordError.classList.remove('show');
            }
        });

        // Validação no submit
        loginForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            let isValid = true;
            
            // Valida login
            if(loginInput.value.trim() === '') {
                loginInput.classList.add('error');
                loginError.classList.add('show');
                isValid = false;
            } else {
                loginInput.classList.remove('error');
                loginError.classList.remove('show');
            }
            
            // Valida senha
            if(passwordInput.value === '') {
                passwordInput.classList.add('error');
                passwordError.querySelector('span').textContent = 'Por favor, insira sua senha';
                passwordError.classList.add('show');
                isValid = false;
            } else if(passwordInput.value.length < 4) {
                passwordInput.classList.add('error');
                passwordError.querySelector('span').textContent = 'A senha deve ter pelo menos 4 caracteres';
                passwordError.classList.add('show');
                isValid = false;
            } else {
                passwordInput.classList.remove('error');
                passwordError.classList.remove('show');
            }
            
            if(isValid) {
                try {
                    // Gera hash da senha
                    const hash = await hashPassword(passwordInput.value);
                    hashedPasswordInput.value = hash;
                    
                    // Limpa a senha original antes de enviar
                    passwordInput.value = '';
                    
                    // Envia o formulário
                    this.submit();
                } catch(error) {
                    showAlert('Erro ao processar login. Tente novamente.', 'error');
                }
            }
        });

        function showAlert(message, type) {
            alertBox.textContent = (type === 'error' ? '❌ ' : '✅ ') + message;
            alertBox.className = 'alert ' + type + ' show';
            
            setTimeout(() => {
                alertBox.classList.remove('show');
            }, 5000);
        }

        // Verifica parâmetro de erro 
        <% 
        String error = request.getParameter("error");
        if("invalid".equals(error)) { 
        %>
            showAlert('Login ou senha incorretos!', 'error');
        <% } %>
    </script>
</body>
</html>