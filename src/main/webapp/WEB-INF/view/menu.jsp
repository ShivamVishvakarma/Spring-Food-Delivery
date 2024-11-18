<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - Add Menu Item</title>
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
            background: rgb(36 71 133);
            backdrop-filter: blur(10px);
            padding: 1rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: -webkit-fill-available;
            z-index: 1000;
        }

        .header h1 {
            color: white;
            text-align: center;
            font-size: 2em;
            font-weight: 600;
        }

        .navbar {
            background: rgb(36 71 133);
            padding: 1rem;
            text-align: right;
            position: fixed;
            top: 65px;
            width: -webkit-fill-available;
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

        .registration-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            margin-top: 8rem;
        }

        .registration-container h3 {
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

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
            background-color: white;
        }

        .form-group input[type="file"] {
            padding: 0.5rem;
            border: 1px dashed #ddd;
            background-color: #f8f9fa;
        }

        .form-group select {
            cursor: pointer;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            background-size: 1em;
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: #667eea;
            outline: none;
        }

        .register-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            transition: transform 0.3s ease;
        }

        .register-btn:hover {
            transform: translateY(-2px);
        }

        .message {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .error {
            background: #fafcfa;
            color: #0db80d;
            border-left: 4px solid #fafcfa;
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

        .preview-image {
            max-width: 200px;
            max-height: 200px;
            margin-top: 10px;
            display: none;
            border-radius: 5px;
        }

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

            .registration-container {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1><i class="fa-solid fa-burger"></i> Online Food Delivery</h1>
    </header>

    <nav class="navbar">
        <s:url var="url_logout" value="/logout"/>
        <s:url var="url_home" value="/seller/dashboard"/>
        <s:url var="url_menu" value="/menu"/>

        <a href="${url_home}"><i class="fas fa-home"></i> Home</a>
        <a href="#"><i class="fas fa-list"></i> Menu</a>
        <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
        <a href="#"><i class="fas fa-question-circle"></i> Help</a>
    </nav>

     <main class="main-content">
            <div class="registration-container">
                <h3><i class="fas fa-plus-circle"></i> Add Menu Item</h3>

                <c:if test="${err != null}">
                    <div class="message error">
                        <i class="fas fa-exclamation-circle"></i> ${err}
                    </div>
                </c:if>

                <c:if test="${message != null}">
                    <div class="message success">
                        <i class="fas fa-check-circle"></i> ${message}
                    </div>
                </c:if>

                <s:url var="url_menu_save" value="/seller/save_menu"/>
                <f:form action="testing1" modelAttribute="command">
                    THIS FORM
                    <div class="form-group">
                        <label for="itemName">Item Name</label>
                        <f:input path="menu.Itemname" id="itemName" cssClass="form-control"/>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <f:textarea path="menu.description" id="description" cssClass="form-control"/>
                    </div>

                    <div class="form-group">
                        <label for="price">Price</label>
                        <f:input path="menu.price" id="price" type="number" step="0.01" cssClass="form-control"/>
                    </div>

                    <div class="form-group">
                        <label for="foodCategory">Category</label>
                        <f:select path="menu.foodCategory" id="foodCategory" cssClass="form-control">
                            <f:option value="" label="Select a Category"/>
                            <f:option value="Vegetarian">Vegetarian</f:option>
                            <f:option value="Non-Vegetarian">Non-Vegetarian</f:option>
                            <f:option value="Desserts">Desserts</f:option>
                            <f:option value="Beverages">Beverages</f:option>
                        </f:select>
                    </div>

                    <button type="submit" class="register-btn">
                        <i class="fas fa-plus-circle"></i> Add Item
                    </button>
                </f:form>
            </div>
        </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>

    <script>
        document.getElementById('image').addEventListener('change', function(e) {
            const preview = document.getElementById('imagePreview');
            const file = e.target.files[0];

            if (file) {
                preview.style.display = 'block';
                const reader = new FileReader();

                reader.onload = function(e) {
                    preview.src = e.target.result;
                }

                reader.readAsDataURL(file);
            }
        });

        // Prevent negative values in price field
        document.getElementById('price').addEventListener('input', function(e) {
            if (e.target.value < 0) {
                e.target.value = 0;
            }
        });
    </script>
</body>
</html>