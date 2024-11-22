<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - Seller Dashboard</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-section h2 {
            color: #333;
            margin-bottom: 1rem;
        }

        .add-restaurant-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1rem;
            transition: transform 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .add-restaurant-btn:hover {
            transform: translateY(-2px);
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

        .restaurant-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .restaurant-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .restaurant-card:hover {
            transform: translateY(-5px);
        }

        .restaurant-image {
            width: 100%;
            height: 200px;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .restaurant-image i {
            font-size: 4rem;
            color: #667eea;
        }

        .restaurant-details {
            padding: 1.5rem;
        }

        .restaurant-details h3 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .restaurant-status {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
            margin: 0.5rem 0;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }

        .restaurant-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .action-btn {
            flex: 1;
            padding: 0.8rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s ease;
        }

        .edit-btn {
            background: #667eea;
            color: white;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
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

            .welcome-section {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .restaurant-grid {
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
        <h1><i class="fas fa-store"></i> Seller Dashboard</h1>
    </header>

    <nav class="navbar">
        <s:url var="url_home" value="/seller/dashboard"/>
        <s:url var="url_orders" value="/seller/orders"/>
        <s:url var="url_profile" value="/user/profile"/>
        <s:url var="url_logout" value="/logout"/>

        <a href="${url_home}"><i class="fas fa-home"></i> Home</a>
        <a href="${url_orders}"><i class="fas fa-shopping-bag"></i> Orders</a>
        <a href="${url_profile}"><i class="fas fa-user"></i> Profile</a>
        <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>

    <main class="main-content">
        <div class="dashboard-container">
            <section class="welcome-section">
                <div>
                    <h2><i class="fas fa-user-circle"></i> Welcome, ${sessionScope.user.name}!</h2>
                    <p>Manage your restaurants and orders from here.</p>
                </div>
                <s:url var="url_add_restaurant" value="/user/contact_form"/>
                <a href="${url_add_restaurant}" class="add-restaurant-btn">
                    <i class="fas fa-plus-circle"></i> Add Restaurant
                </a>
            </section>

            <section class="stats-container">
                <div class="stat-card">
                    <i class="fas fa-store"></i>
                    <h3>Total Restaurants</h3>
                    <p>2</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>Active Orders</h3>
                    <p>0</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-chart-line"></i>
                    <h3>Today's Revenue</h3>
                    <p>₹0</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-star"></i>
                    <h3>Average Rating</h3>
                    <p>0</p>
                </div>
            </section>

          <%--  <div class="restaurant-grid">
                <!-- Restaurant 1 -->
                <div class="restaurant-card">
                    <div class="restaurant-image">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="restaurant-details">
                        <h3>Spice Garden</h3>
                        <p>Indian Restaurant</p>
                        <span class="restaurant-status status-active">Active</span>
                        <div class="restaurant-actions">
                            <button class="action-btn edit-btn"><i class="fas fa-edit"></i> Edit</button>
                            <button class="action-btn delete-btn"><i class="fas fa-trash"></i> Delete</button>
                        </div>
                    </div>
                </div>

                <!-- Restaurant 2 -->
                <div class="restaurant-card">
                    <div class="restaurant-image">
                        <i class="fas fa-pizza-slice"></i>
                    </div>
                    <div class="restaurant-details">
                        <h3>Pizza Paradise</h3>
                        <p>Italian Restaurant</p>
                        <span class="restaurant-status status-active">Active</span>
                        <div class="restaurant-actions">
                            <button class="action-btn edit-btn"><i class="fas fa-edit"></i> Edit</button>
                            <button class="action-btn delete-btn"><i class="fas fa-trash"></i> Delete</button>
                        </div>
                    </div>
                </div>

                <!-- Restaurant 3 -->
                <div class="restaurant-card">
                    <div class="restaurant-image">
                        <i class="fas fa-hamburger"></i>
                    </div>
                    <div class="restaurant-details">
                        <h3>Burger Bros</h3>
                        <p>Fast Food Restaurant</p>
                        <span class="restaurant-status status-inactive">Inactive</span>
                        <div class="restaurant-actions">
                            <button class="action-btn edit-btn"><i class="fas fa-edit"></i> Edit</button>
                            <button class="action-btn delete-btn"><i class="fas fa-trash"></i> Delete</button>
                        </div>
                    </div>
                </div>
            </div> --%>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>