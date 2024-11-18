<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - User Dashboard</title>
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
            padding: 2rem;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .welcome-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .welcome-section h2 {
            color: #333;
            margin-bottom: 1rem;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .stat-card i {
            font-size: 2rem;
            color: #667eea;
            margin-bottom: 0.5rem;
        }

        .food-items-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
        }

        .food-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .food-card:hover {
            transform: translateY(-5px);
        }

        .food-image {
            width: 100%;
            height: 200px;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .food-image i {
            font-size: 4rem;
            color: #667eea;
        }

        .food-details {
            padding: 1.5rem;
        }

        .food-details h3 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .food-price {
            color: #667eea;
            font-size: 1.25rem;
            font-weight: bold;
            margin: 0.5rem 0;
        }

        .food-description {
            color: #666;
            margin-bottom: 1rem;
        }

        .order-btn {
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

        .order-btn:hover {
            transform: translateY(-2px);
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

            .main-content {
                padding: 1rem;
            }

            .food-items-grid {
                grid-template-columns: 1fr;
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

        }
    </style>
</head>
<body>
    <header class="header">
        <h1><i class="fas fa-utensils"></i> Online Food Delivery</h1>
    </header>

    <nav class="navbar">
        <s:url var="url_home" value="/user/dashboard"/>
        <s:url var="url_orders" value="/user/orders"/>
        <s:url var="url_profile" value="/user/profile"/>
        <s:url var="url_logout" value="/logout"/>

        <a href="${url_home}"><i class="fas fa-home"></i> Home</a>
        <a href="${url_orders}"><i class="fas fa-shopping-bag"></i> My Orders</a>
        <a href="${url_profile}"><i class="fas fa-user"></i> Profile</a>
        <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>

    <main class="main-content">
        <div class="dashboard-container">
            <section class="welcome-section">
                <h2><i class="fas fa-user-circle"></i> Welcome, ${sessionScope.user.name}!</h2>
                <p>Browse our delicious menu and place your order.</p>
            </section>

            <section class="stats-container">
                <div class="stat-card">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>Total Orders</h3>
                    <p>12</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-heart"></i>
                    <h3>Favorites</h3>
                    <p>5</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-wallet"></i>
                    <h3>Wallet Balance</h3>
                    <p>₹500</p>
                </div>
            </section>

            <div class="food-items-grid">
                <!-- Food Item 1 -->
                <div class="food-card">
                    <div class="food-image">
                        <i class="fas fa-pizza-slice"></i>
                    </div>
                    <div class="food-details">
                        <h3>Margherita Pizza</h3>
                        <p class="food-description">Classic pizza with tomato sauce, mozzarella, and basil</p>
                        <p class="food-price">₹299</p>
                        <button class="order-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                    </div>
                </div>

                <!-- Food Item 2 -->
                <div class="food-card">
                    <div class="food-image">
                        <i class="fas fa-hamburger"></i>
                    </div>
                    <div class="food-details">
                        <h3>Classic Burger</h3>
                        <p class="food-description">Juicy beef patty with fresh vegetables and special sauce</p>
                        <p class="food-price">₹199</p>
                        <button class="order-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                    </div>
                </div>

                <!-- Food Item 3 -->
                <div class="food-card">
                    <div class="food-image">
                        <i class="fas fa-drumstick-bite"></i>
                    </div>
                    <div class="food-details">
                        <h3>Butter Chicken</h3>
                        <p class="food-description">Creamy butter chicken with naan bread</p>
                        <p class="food-price">₹349</p>
                        <button class="order-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                    </div>
                </div>

                <!-- Food Item 4 -->
                <div class="food-card">
                    <div class="food-image">
                        <i class="fas fa-fish"></i>
                    </div>
                    <div class="food-details">
                        <h3>Grilled Fish</h3>
                        <p class="food-description">Fresh grilled fish with herbs and lemon</p>
                        <p class="food-price">₹399</p>
                        <button class="order-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                    </div>
                </div>

                <!-- Food Item 5 -->
                <div class="food-card">
                    <div class="food-image">
                        <i class="fas fa-ice-cream"></i>
                    </div>
                    <div class="food-details">
                        <h3>Ice Cream Sundae</h3>
                        <p class="food-description">Assorted ice cream flavors with toppings</p>
                        <p class="food-price">₹149</p>
                        <button class="order-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                    </div>
                </div>

                <!-- Food Item 6 -->
                <div class="food-card">
                    <div class="food-image">
                        <i class="fas fa-coffee"></i>
                    </div>
                    <div class="food-details">
                        <h3>Cold Coffee</h3>
                        <p class="food-description">Refreshing cold coffee with ice cream</p>
                        <p class="food-price">₹129</p>
                        <button class="order-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>