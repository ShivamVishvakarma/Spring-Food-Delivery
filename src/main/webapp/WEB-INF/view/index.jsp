<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - Login</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
           background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 1rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);

        }

        .header h1 {
            color: white;
            text-align: center;
            font-size: 2em;
            font-weight: 600;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.05);
            padding: 1rem;
            text-align: right;

        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            margin: 0 0.2rem;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .navbar a:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .login-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .login-container h3 {
            color: #333;
            margin-bottom: 1.5rem;
            text-align: center;
            font-size: 1.5em;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #666;
        }

        .form-group input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            border-color: #667eea;
            outline: none;
        }

        .login-btn {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            transition: transform 0.3s ease;
        }

        .login-btn:hover {
            transform: translateY(-2px);
        }

        .register-link {
            text-align: center;
            margin-top: 1rem;
        }

        .register-link a {
            color: #667eea;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .message {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .error {
            background: #ffe6e6;
            color: #d63031;
            border-left: 4px solid #d63031;
        }

        .success {
            background: #e6ffe6;
            color: #27ae60;
            border-left: 4px solid #27ae60;
        }

        .footer {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            text-align: center;
            padding: 1rem;
            margin-top: auto;
        }

        .footer a {
            color: white;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.5em;
            }

            .navbar {
                text-align: center;
            }

            .navbar a {
                display: inline-block;
                margin: 0.2rem;
            }

            .main-content {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1><i class="fa-solid fa-burger"></i> Online Food Delivery </h1>
    </header>

    <nav class="navbar">
        <s:url var="url_logout" value="/logout"/>

        <c:if test="${sessionScope.userId==null}">
            <s:url var="url_reg_form" value="/reg_form"/>
            <s:url var="url_index" value="/index"/>
            <a href="${url_index}"><i class="fas fa-home"></i> Home</a>
            <a href="${url_index}"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="${url_reg_form}"><i class="fas fa-user-plus"></i> Register</a>
            <a href="#"><i class="fas fa-info-circle"></i> About</a>
            <a href="#"><i class="fas fa-question-circle"></i> Help</a>
        </c:if>

        <c:if test="${sessionScope.userId!=null && sessionScope.role == 1}">
            <a href="#"><i class="fas fa-home"></i> Home</a>
            <a href="<s:url value="/admin/users"/>"><i class="fas fa-users"></i> User List</a>
            <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </c:if>

        <c:if test="${sessionScope.userId!=null && sessionScope.role == 2}">
            <s:url var="url_uhome" value="/user/dashboard"/>
            <s:url var="url_cform" value="/user/contact_form"/>
            <s:url var="url_clist" value="/user/clist"/>
            <a href="${url_uhome}"><i class="fas fa-home"></i> Home</a>
            <a href="${url_cform}"><i class="fas fa-plus-circle"></i> Add Contact</a>
            <a href="${url_clist}"><i class="fas fa-list"></i> Contact List</a>
            <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </c:if>
    </nav>

    <main class="main-content">
        <div class="login-container">
            <h3><i class="fas fa-user-circle"></i> User Login</h3>

            <c:if test="${err!=null}">
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i> ${err}
                </div>
            </c:if>

            <c:if test="${param.act eq 'lo'}">
                <div class="message success">
                    <i class="fas fa-check-circle"></i> Logout Successfully! Thanks for using our Food application.
                </div>
            </c:if>

            <c:if test="${param.act eq 'reg'}">
                <div class="message success">
                    <i class="fas fa-check-circle"></i> User Registered Successfully. Please login
                </div>
            </c:if>

            <s:url var="url_login" value="/login"/>
            <f:form action="${url_login}" modelAttribute="command">
                <div class="form-group">
                    <label for="loginName"><i class="fas fa-user"></i> Username</label>
                    <f:input path="loginName" id="loginName" placeholder="Enter your username" value="shivam"/>
                </div>

                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <f:password path="password" id="password" placeholder="Enter your password" value="12345"/>
                </div>

                <button type="submit" class="login-btn">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>

                <div class="register-link">
                    <p>Don't have an account? <a href="<s:url value="/reg_form"/>">Register Now</a></p>
                </div>
            </f:form>
        </div>
    </main>

    <footer class="footer">
        <p> &copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>