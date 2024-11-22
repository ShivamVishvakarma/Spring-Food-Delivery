<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        .restaurant-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                    gap: 2rem;
                    padding: 1rem;
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

                .restaurant-details {
                    padding: 1.5rem;
                }

                .restaurant-details h3 {
                    color: #333;
                    margin-bottom: 0.5rem;
                }

                .restaurant-info {
                    color: #666;
                    margin-bottom: 1rem;
                }

                .view-menu-btn {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    padding: 0.8rem 1.5rem;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    width: 100%;
                    font-size: 1rem;
                    transition: transform 0.3s ease;
                    text-decoration: none;
                    display: inline-block;
                    text-align: center;
                }

                .view-menu-btn:hover {
                    transform: translateY(-2px);
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
        <h1><i class="fa-solid fa-burger"></i> Online Food Delivery</h1>
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
                    <p>0</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-heart"></i>
                    <h3>Favorites</h3>
                    <p>0</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-wallet"></i>
                    <h3>Wallet Balance</h3>
                    <p>₹0</p>
                </div>
            </section>

            <div class="food-items-grid">
                              <c:forEach var="contact" items="${contact}">
                                  <div class="food-card">
                                      <div class="food-image">
                                          <i class="fas fa-store"></i>
                                      </div>
                                      <div class="food-details">
                                          <h3>${contact.name}</h3>
                                          <p class="food-description">
                                              <i class="fas fa-map-marker-alt"></i> ${contact.address}
                                          </p>
                                          <p class="food-description">
                                              <i class="fas fa-phone"></i> ${contact.phone}<br>
                                              <i class="fas fa-envelope"></i> ${contact.email}
                                          </p>
                                         <div class="food-details">

                                             <s:url var="url_view" value="/user/menu_list">
                                             <s:param name="cid" value="${contact.contactId}"/>
                                               </s:url>
                                             <a href="${url_view}" class="order-btn">
                                                 <i class="fas fa-utensils"></i> View Menu
                                             </a>
                                         </div>
                                      </div>
                                  </div>
                              </c:forEach>
                          </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>