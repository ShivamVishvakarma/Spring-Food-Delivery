<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - Welcome</title>
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
            flex-direction: column;
            align-items: center;
            padding: 3rem 2rem;
            color: white;
        }

        .hero-section {
            text-align: center;
            margin-bottom: 3rem;
        }

        .hero-section h2 {
            font-size: 2.5em;
            margin-bottom: 1rem;
        }

        .hero-section p {
            font-size: 1.2em;
            margin-bottom: 2rem;
            max-width: 600px;
        }

        .cta-button {
            background: white;
            color: #1e3c72;
            padding: 1rem 2rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: bold;
            transition: transform 0.3s ease;
            display: inline-block;
        }

        .cta-button:hover {
            transform: translateY(-2px);
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            width: 100%;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 2rem;
            border-radius: 10px;
            text-align: center;
            backdrop-filter: blur(10px);
        }

        .feature-card i {
            font-size: 2.5em;
            margin-bottom: 1rem;
        }

        .feature-card h3 {
            margin-bottom: 1rem;
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

            .hero-section h2 {
                font-size: 2em;
            }

            .features {
                grid-template-columns: 1fr;
            }

            .main-content {
                padding: 2rem 1rem;
            }
            .footer
            {
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


                    }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1><i class="fa-solid fa-burger"></i> Online Food Delivery</h1>
    </header>

    <nav class="navbar">
       <s:url var="url_home" value="/"/>
                       <s:url var="url_login" value="/login"/>
                        <s:url var="url_register" value="/reg_form"/>
                        <s:url var="url_logout" value="/logout"/>


                       <a href="${url_home}"><i class="fas fa-home"></i> Home</a>
                               <c:if test="${userId == null}">

                                   <a href="${url_login}"><i class="fa-solid fa-right-to-bracket"></i> Login</a>
                                   <a href="${url_register}"><i class="fas fa-sign-out-alt"></i> Register</a>
                               </c:if>
    </nav>

    <main class="main-content">
        <section class="hero-section">
            <h2>Delicious Food Delivered to Your Doorstep</h2>
            <p>Experience the convenience of ordering your favorite meals from the best restaurants in your area. Fast delivery, amazing taste, and exceptional service!</p>
         <%--   <a href="register.html" class="cta-button"><i class="fas fa-user-plus"></i> Get Started</a> --%>
        </section>

        <section class="features">
            <div class="feature-card">
                <i class="fas fa-utensils"></i>
                <h3>Wide Selection</h3>
                <p>Choose from hundreds of restaurants and thousands of delicious menu items.</p>
            </div>

            <div class="feature-card">
                <i class="fas fa-truck"></i>
                <h3>Fast Delivery</h3>
                <p>Get your food delivered quickly and efficiently to your location.</p>
            </div>

            <div class="feature-card">
                <i class="fas fa-star"></i>
                <h3>Best Quality</h3>
                <p>Experience premium quality food from the finest restaurants in town.</p>
            </div>
        </section>
    </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>