<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - My Orders</title>
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

        .orders-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .orders-header {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .orders-header h2 {
            color: #333;
            margin-bottom: 1rem;
        }

        .order-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }

        .order-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .status-delivered {
            background: #c6f6d5;
            color: #2f855a;
        }

        .status-processing {
            background: #feebc8;
            color: #c05621;
        }

        .order-items {
            margin-bottom: 1rem;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
        }

        .item-name {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .order-total {
            display: flex;
            justify-content: space-between;
            padding-top: 1rem;
            border-top: 1px solid #eee;
            font-weight: bold;
        }

        .reorder-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: transform 0.3s ease;
            margin-top: 1rem;
        }

        .reorder-btn:hover {
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


                }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            .order-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
        .empty-state {
                    text-align: center;
                    padding: 3rem;
                    background: white;
                    border-radius: 10px;
                    margin: 2rem 0;
                }

                .empty-state i {
                    font-size: 4rem;
                    color: #cbd5e0;
                    margin-bottom: 1rem;
                }

                .empty-state h3 {
                    color: #4a5568;
                    margin-bottom: 0.5rem;
                }

                .empty-state p {
                    color: #718096;
                }

                .loading {
                    display: none;
                    text-align: center;
                    padding: 2rem;
                }

                .loading i {
                    font-size: 2rem;
                    color: white;
                    animation: spin 1s linear infinite;
                }

                @keyframes spin {
                    0% { transform: rotate(0deg); }
                    100% { transform: rotate(360deg); }
                }

                /* Toast notification styles */
                .toast {
                    position: fixed;
                    bottom: 2rem;
                    right: 2rem;
                    background: white;
                    padding: 1rem 2rem;
                    border-radius: 5px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    display: none;
                    z-index: 1000;
                }

                .toast.success {
                    border-left: 4px solid #48bb78;
                }

                .toast.error {
                    border-left: 4px solid #f56565;
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
                <a href="${url_orders}" class="active"><i class="fas fa-shopping-bag"></i> My Orders</a>
                <a href="${url_profile}"><i class="fas fa-user"></i> Profile</a>
                <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </nav>

            <main class="main-content">
                <div class="orders-container">
                    <section class="orders-header">
                        <div>
                            <h2><i class="fas fa-shopping-bag"></i> My Orders</h2>
                            <p>Track and manage your orders</p>
                        </div>
                        <div class="filter-section">
                            <select class="filter-dropdown" id="orderStatus">
                                <option value="all">All Orders</option>
                                <option value="ongoing">Ongoing</option>
                                <option value="delivered">Delivered</option>
                                <option value="cancelled">Cancelled</option>
                            </select>
                            <select class="filter-dropdown" id="orderSort">
                                <option value="recent">Most Recent</option>
                                <option value="oldest">Oldest First</option>
                            </select>
                        </div>
                    </section>

                    <div id="ordersContent">
                        <!-- Previous order card content remains the same -->

                        <!-- Completed Order Example -->
                        <div class="order-card">
                            <div class="order-header">
                                <div class="order-info">
                                    <div>
                                        <h3>Order #12344</h3>
                                        <p>Placed on: March 18, 2024, 1:15 PM</p>
                                    </div>
                                </div>
                                <span class="order-status status-delivered">Delivered</span>
                            </div>

                            <div class="order-items">
                                <div class="order-item">
                                    <div class="item-details">
                                        <div class="item-image">
                                            <i class="fas fa-bowl-food"></i>
                                        </div>
                                        <div class="item-info">
                                            <h4>Chicken Bowl</h4>
                                            <p>Quantity: 1</p>
                                        </div>
                                    </div>
                                    <div class="item-price">₹249</div>
                                </div>
                            </div>

                            <div class="order-summary">
                                <div class="summary-row">
                                    <span>Subtotal</span>
                                    <span>₹249</span>
                                </div>
                                <div class="summary-row">
                                    <span>Delivery Fee</span>
                                    <span>₹40</span>
                                </div>
                                <div class="summary-row">
                                    <span>Taxes</span>
                                    <span>₹25</span>
                                </div>
                                <div class="summary-row total-row">
                                    <span>Total</span>
                                    <span>₹314</span>
                                </div>
                            </div>

                            <div class="order-actions">
                                <button class="action-btn reorder-btn" onclick="reorderItems(12344)">
                                    <i class="fas fa-redo"></i> Reorder
                                </button>
                                <button class="action-btn help-btn" onclick="showHelp(12344)">
                                    <i class="fas fa-question-circle"></i> Need Help
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Empty State -->
                    <div class="empty-state" style="display: none;">
                        <i class="fas fa-shopping-bag"></i>
                        <h3>No Orders Found</h3>
                        <p>You haven't placed any orders yet.</p>
                        <a href="${url_home}" class="action-btn reorder-btn" style="display: inline-block; margin-top: 1rem;">
                            Start Ordering
                        </a>
                    </div>

                    <!-- Loading State -->
                    <div class="loading">
                        <i class="fas fa-spinner"></i>
                    </div>

                    <!-- Pagination -->
                    <div class="pagination">
                        <button class="page-btn" onclick="changePage(1)">1</button>
                        <button class="page-btn active" onclick="changePage(2)">2</button>
                        <button class="page-btn" onclick="changePage(3)">3</button>
                    </div>
                </div>
            </main>

            <div class="toast" id="toast">
                <p></p>
            </div>

            <footer class="footer">
                <p>&copy; 2024 Online Food Delivery. All rights reserved.</p>
                <p>
                    <a href="#">Terms of Service</a> |
                    <a href="#">Privacy Policy</a> |
                    <a href="#">Contact Us</a>
                </p>
            </footer>

            <script>
                // Filter orders based on status and sort preference
                function filterOrders() {
                    const status = document.getElementById('orderStatus').value;
                    const sort = document.getElementById('orderSort').value;
                    showLoading();
                    // Add your filter logic here
                    // This is where you would typically make an AJAX call to get filtered orders
                    setTimeout(hideLoading, 1000); // Simulate loading
                }

                // Reorder items from a previous order
                function reorderItems(orderId) {
                    showToast('Adding items to cart...', 'success');
                    // Add your reorder logic here
                }

                // Show help/support for an order
                function showHelp(orderId) {
                    // Add your help dialog logic here
                }

                // Pagination handler
                function changePage(page) {
                    showLoading();
                    // Add your pagination logic here
                    setTimeout(hideLoading, 1000); // Simulate loading
                }

                // Toast notification
                function showToast(message, type = 'success') {
                    const toast = document.getElementById('toast');
                    toast.textContent = message;
                    toast.className = `toast ${type}`;
                    toast.style.display = 'block';
                    setTimeout(() => {
                        toast.style.display = 'none';
                    }, 3000);
                }

                // Loading state handlers
                function showLoading() {
                    document.querySelector('.loading').style.display = 'block';
                }

                function hideLoading() {
                    document.querySelector('.loading').style.display = 'none';
                }

                // Event listeners
                document.getElementById('orderStatus').addEventListener('change', filterOrders);
                document.getElementById('orderSort').addEventListener('change', filterOrders);
            </script>
        </body>
        </html>