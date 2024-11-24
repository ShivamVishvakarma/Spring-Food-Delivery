<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Food Delivery</title>
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
            padding: 1rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .header h1 {
            color: white;
            text-align: center;
            font-size: 2em;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.05);
            padding: 1rem;
            text-align: right;
            position: fixed;
            top: 65px;
            width: 100%;
            z-index: 999;
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
            margin-top: 8rem;
        }

        .checkout-container {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 1000px;
            margin: 0 auto;
        }

        .checkout-section {
            margin-bottom: 2rem;
            padding: 1.5rem;
            border: 1px solid #eee;
            border-radius: 8px;
        }

        .section-title {
            color: #2a5298;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #2a5298;
        }

        .cart-items {
            margin-bottom: 1.5rem;
        }

        .cart-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }

        .item-image {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
            margin-right: 1rem;
        }

        .item-details {
            flex: 1;
        }

        .item-price {
            font-weight: bold;
            color: #2a5298;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #2a5298;
            outline: none;
        }

        .payment-options {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .payment-option {
            flex: 1;
            padding: 1rem;
            border: 2px solid #ddd;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-option.selected {
            border-color: #2a5298;
            background-color: #f0f4ff;
        }

        .payment-details {
            margin-top: 1rem;
            padding: 1rem;
            background-color: #f8f9fa;
            border-radius: 8px;
            display: none;
        }

        .order-summary {
            background-color: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .total-row {
            font-size: 1.2rem;
            font-weight: bold;
            color: #2a5298;
            border-top: 2px solid #ddd;
            padding-top: 1rem;
            margin-top: 1rem;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background-color: #2a5298;
            color: white;
            width: 100%;
        }

        .btn-primary:hover {
            background-color: #1e3c72;
            transform: translateY(-2px);
        }

        .error-message {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .footer {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            text-align: center;
            padding: 1rem;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            .payment-options {
                flex-direction: column;
            }

            .cart-item {
                flex-direction: column;
                text-align: center;
            }

            .item-image {
                margin-right: 0;
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1><i class="fas fa-shopping-bag"></i> Checkout</h1>
    </header>

    <nav class="navbar">
        <s:url var="url_home" value="/user/dashboard"/>
        <s:url var="url_cart" value="/user/cart"/>
        <s:url var="url_orders" value="/user/orders"/>

        <a href="${url_home}"><i class="fas fa-home"></i> Home</a>
        <a href="${url_cart}"><i class="fas fa-shopping-cart"></i> Cart</a>
        <a href="${url_orders}"><i class="fas fa-list"></i> My Orders</a>
    </nav>

    <main class="main-content">
        <div class="checkout-container">
            <sf:form action="${pageContext.request.contextPath}/user/checkout" method="post" id="checkoutForm" modelAttribute="checkout">
            <!-- Restaurant Details Section -->
                            <div class="checkout-section">
                                <h3 class="section-title"><i class="fas fa-store"></i> Restaurant Details</h3>
                                <div class="restaurant-info">
                                    <h4>${restaurant.name}</h4>
                                    <p><i class="fas fa-map-marker-alt"></i> ${restaurant.address}</p>
                                    <p><i class="fas fa-phone"></i> ${restaurant.phone}</p>
                                    <p><i class="fas fa-envelope"></i> ${restaurant.email}</p>
                                </div>
                            </div>

                <!-- Cart Items Section -->
                <div class="checkout-section">
                                    <h3 class="section-title"><i class="fas fa-shopping-cart"></i> Order Items</h3>
                                    <div class="cart-items">
                                        <c:forEach var="item" items="${cartItems}">
                                            <div class="cart-item">
                                                <img src="data:image/jpeg;base64,${item.menu.image}" alt="${item.menu.itemname}" class="item-image">
                                                <div class="item-details">
                                                    <h4>${item.menu.itemname}</h4>
                                                    <p>${item.menu.description}</p>
                                                    <p>Quantity: ${item.quantity}</p>
                                                    <p class="item-price">₹${item.menu.price * item.quantity}</p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                <!-- Delivery Address Section -->
                <div class="checkout-section">
                                    <h3 class="section-title"><i class="fas fa-map-marker-alt"></i> Delivery Address</h3>
                                    <div class="form-group">
                                        <label for="deliveryAddress">Street Address *</label>
                                        <sf:input path="deliveryAddress" class="form-control" required="required"/>
                                        <sf:errors path="deliveryAddress" cssClass="error-message"/>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="city">City *</label>
                                            <sf:input path="city" class="form-control" required="required"/>
                                            <sf:errors path="city" cssClass="error-message"/>
                                        </div>

                                        <div class="form-group">
                                            <label for="state">State *</label>
                                            <sf:input path="state" class="form-control" required="required"/>
                                            <sf:errors path="state" cssClass="error-message"/>
                                        </div>

                                        <div class="form-group">
                                            <label for="pincode">Pincode *</label>
                                            <sf:input path="pincode" class="form-control" required="required"/>
                                            <sf:errors path="pincode" cssClass="error-message"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="contactNumber">Contact Number *</label>
                                        <sf:input path="contactNumber" class="form-control" required="required"/>
                                        <sf:errors path="contactNumber" cssClass="error-message"/>
                                    </div>
                                </div>

                <!-- Payment Section -->
                <div class="checkout-section">
                    <h3 class="section-title"><i class="fas fa-credit-card"></i> Payment Method</h3>
                    <div class="payment-options">
                        <div class="payment-option" onclick="selectPaymentMethod('UPI')">
                            <sf:radiobutton path="paymentMethod" value="UPI" id="upi"/>
                            <label for="upi">
                                <i class="fas fa-mobile-alt"></i> UPI Payment
                            </label>
                        </div>
                        <div class="payment-option" onclick="selectPaymentMethod('COD')">
                            <sf:radiobutton path="paymentMethod" value="COD" id="cod"/>
                            <label for="cod">
                                <i class="fas fa-money-bill-wave"></i> Cash on Delivery
                            </label>
                        </div>
                    </div>

                    <div id="upiDetails" class="payment-details">
                        <div class="form-group">
                            <label for="upiId">UPI ID *</label>
                            <sf:input path="upiId" class="form-control" placeholder="Enter your UPI ID (e.g., name@upi)"/>
                            <sf:errors path="upiId" cssClass="error-message"/>
                        </div>
                    </div>
                </div>

                <!-- Order Summary Section -->
                <div class="checkout-section">
                                    <h3 class="section-title"><i class="fas fa-receipt"></i> Order Summary</h3>
                                    <div class="order-summary">
                                        <div class="summary-row">
                                            <span>Items Subtotal</span>
                                            <span>₹<fmt:formatNumber value="${subtotal}" pattern="#,##0.00"/></span>
                                        </div>
                                        <div class="summary-row">
                                            <span>Delivery Charge</span>
                                            <span>₹40.00</span>
                                        </div>
                                        <sf:hidden path="totalAmount" value="${subtotal + 40}"/>
                                        <div class="summary-row total-row">
                                            <span>Total Amount</span>
                                            <span>₹<fmt:formatNumber value="${subtotal + 40}" pattern="#,##0.00"/></span>
                                        </div>
                                    </div>
                                </div>

                <<sf:hidden path="userId" value="${sessionScope.userId}"/>
                                 <sf:hidden path="contactId" value="${restaurant.contactId}"/>

                                 <button type="submit" class="btn btn-primary">
                                     <i class="fas fa-check-circle"></i> Place Order
                                 </button>
                             </sf:form>
                         </div>
                     </main>

    <footer class="footer">
        <p>&copy; 2024 Food Delivery. All rights reserved.</p>
    </footer>

    <script>
        function selectPaymentMethod(method) {
            // Remove selected class from all options
            document.querySelectorAll('.payment-option').forEach(option => {
                option.classList.remove('selected');
            });

            // Add selected class to chosen option
            const selectedOption = document.querySelector(`input[value="${method}"]`)
                .closest('.payment-option');
            selectedOption.classList.add('selected');

            // Show/hide UPI details
            const upiDetails = document.getElementById('upiDetails');
            if (method === 'UPI') {
                upiDetails.style.display = 'block';
                document.getElementById('upiId').required = true;
            } else {
                upiDetails.style.display = 'none';
                document.getElementById('upiId').required = false;
            }
        }

        // Form validation
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');

            if (!paymentMethod) {
                e.preventDefault();
                alert('Please select a payment method');
                return;
            }

            if (paymentMethod.value === 'UPI') {
                const upiId = document.getElementById('upiId').value;
                if (!upiId) {
                    e.preventDefault();
                    alert('Please enter your UPI ID');
                    return;
                }

                // Basic UPI ID validation
                const upiPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z]{3,}$/;
                if (!upiPattern.test(upiId)) {
                    e.preventDefault();
                    alert('Please enter a valid UPI ID (e.g., name@upi)');
                    return;
                }
            }
        });
    </script>

                </body>
                </html>