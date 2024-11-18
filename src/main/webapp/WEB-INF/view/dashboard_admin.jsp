<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - Admin Dashboard</title>
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
            color: #1e3c72;
            margin-bottom: 0.5rem;
        }

        .restaurant-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
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
            color: #1e3c72;
        }

        .restaurant-details {
            padding: 1.5rem;
        }

        .restaurant-details h3 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .restaurant-status {
            color: #1e3c72;
            font-size: 1.25rem;
            font-weight: bold;
            margin: 0.5rem 0;
        }

        .restaurant-description {
            color: #666;
            margin-bottom: 1rem;
        }

        .action-btn {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            transition: transform 0.3s ease;
            margin-bottom: 0.5rem;
        }

        .action-btn.delete {
            background: linear-gradient(135deg, #d32f2f 0%, #c62828 100%);
        }

        .action-btn:hover {
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

            .restaurant-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1><i class="fas fa-user-shield"></i> Admin Dashboard</h1>
    </header>

    <nav class="navbar">
        <s:url var="url_home" value="/admin/dashboard"/>
        <s:url var="url_restaurants" value="/user/clist"/>
        <s:url var="url_seller" value="/admin/sellers"/>
        <s:url var="url_users" value="/admin/buyers"/>
        <s:url var="url_reports" value="/admin/reports"/>
        <s:url var="url_logout" value="/logout"/>

        <a href="${url_home}"><i class="fas fa-home"></i> Home</a>
        <a href="${url_restaurants}"><i class="fas fa-store"></i> Restaurants</a>
        <a href="${url_seller}"><i class="fas fa-users"></i> Sellers</a>
         <a href="${url_users}"><i class="fas fa-users"></i> Buyer</a>
        <a href="${url_reports}"><i class="fas fa-chart-bar"></i> Reports</a>
        <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>

    <main class="main-content">
        <div class="dashboard-container">
            <section class="welcome-section">
                <h2><i class="fas fa-user-shield"></i> Welcome, Admin!</h2>
                <p>Manage restaurants and monitor platform performance.</p>
            </section>

            <section class="stats-container">
                <div class="stat-card">
                    <i class="fas fa-store"></i>
                    <h3>Total Restaurants</h3>
                    <p>25</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-users"></i>
                    <h3>Total Users</h3>
                    <p>1,250</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>Total Orders</h3>
                    <p>3,487</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-rupee-sign"></i>
                    <h3>Revenue</h3>
                    <p>₹2,45,000</p>
                </div>
            </section>

            <div class="restaurant-grid">
                <!-- Restaurant 1 -->
                <div class="restaurant-card">
                    <div class="restaurant-image">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="restaurant-details">
                        <h3>Spice Garden</h3>
                        <p class="restaurant-description">Authentic Indian Cuisine</p>
                        <p class="restaurant-status">Active</p>
                        <button class="action-btn"><i class="fas fa-edit"></i> Edit Details</button>
                        <button class="action-btn delete"><i class="fas fa-trash"></i> Remove</button>
                    </div>
                </div>

                <!-- Restaurant 2 -->
                <div class="restaurant-card">
                    <div class="restaurant-image">
                        <i class="fas fa-pizza-slice"></i>
                    </div>
                    <div class="restaurant-details">
                        <h3>Pizza Paradise</h3>
                        <p class="restaurant-description">Best Italian Pizza</p>
                        <p class="restaurant-status">Active</p>
                        <button class="action-btn"><i class="fas fa-edit"></i> Edit Details</button>
                        <button class="action-btn delete"><i class="fas fa-trash"></i> Remove</button>
                    </div>
                </div>

                <!-- Restaurant 3 -->
                <div class="restaurant-card">
                    <div class="restaurant-image">
                        <i class="fas fa-hamburger"></i>
                    </div>
                    <div class="restaurant-details">
                        <h3>Burger House</h3>
                        <p class="restaurant-description">Gourmet Burgers</p>
                        <p class="restaurant-status">Active</p>
                        <button class="action-btn"><i class="fas fa-edit"></i> Edit Details</button>
                        <button class="action-btn delete"><i class="fas fa-trash"></i> Remove</button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html