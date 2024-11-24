<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart - Online Food Delivery</title>
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
            left: 0;
            right: 0;
            z-index: 1000;
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
            position: fixed;
            top: 65px;
            width: 100%;
            z-index: 1000;
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

        .background-image {
            position: fixed;
            top: 0;
            left: -32rem;
            width: 160%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .background-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.6;
        }

        .main-content {
            flex: 1;
            padding: 2rem;
            margin-top: 8rem;
        }

        .cart-container {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-left: 5px solid linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        }

        .cart-empty {
            text-align: center;
            padding: 2rem;
        }

        .cart-empty h3 {
            color: #2e7d32;
            margin-bottom: 1rem;
        }

        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
            transition: background-color 0.3s ease;
        }
        .text-center {
            text-align: center;
        }

        .btn-small {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }

        .btn a {
            text-decoration: none;
        }

        .cart-item:hover {
            background-color: rgba(124, 179, 66, 0.05);
        }

        .cart-item-details {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex: 1;
        }
.shop-cart {
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 2rem;
    width: 100%;
}

        .cart-item-image {
            max-width: 100px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .cart-item-info {
            flex: 1;
        }

        .cart-item-info h4 {
            color: #486ace;
            margin-bottom: 0.5rem;
        }

        .cart-item-controls {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .quantity-control button {
            background: none;
            border: none;
            padding: 0.5rem;
            cursor: pointer;
            color: #7cb342;
            font-weight: bold;
        }

        .quantity-control input {
            width: 50px;
            text-align: center;
            border: none;
            padding: 0.5rem;
        }

        .cart-summary {
            display: flex;
            justify-content: space-between;
            margin-top: 2rem;
            padding: 1rem;
            background-color: #f0f4f0;
            border-radius: 10px;
        }

        .cart-summary-details {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .cart-summary-details h3 {
            color: #205ac7;
        }

        .cart-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 1rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        a.btn {
            text-decoration: none;
        }

        .btn-primary {
            background-color: rgb(45 25 170 / 84%);
            color: white;
        }

        .btn-secondary {
            background-color: #f0f0f0;
            color: #333;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .message {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            position: fixed;
            top: 120px;
            left: 20px;
            z-index: 1001;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 10px;
            opacity: 1;
            transition: opacity 0.5s ease-out;
        }

        .message.success {
            background-color: #f0fdf4;
            color: #16a34a;
            border-left: 4px solid #16a34a;
        }

        .message.error {
            background-color: #fef2f2;
            color: #dc2626;
            border-left: 4px solid #dc2626;
        }

        .footer {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            text-align: center;
            padding: 1rem;
            margin-top: auto;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        .footer a {
            color: white;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .cart-item {
                flex-direction: column;
                text-align: center;
            }

            .cart-item-controls {
                flex-direction: column;
            }

            .cart-summary {
                flex-direction: column;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <header class="header">
               <h1><i class="fas fa-burger"></i> Online Food Delivery</h1>
           </header>

   <nav class="navbar">
          <s:url var="url_home" value="/user/dashboard"/>
          <s:url var="url_orders" value="/user/orders"/>
          <s:url var="url_profile" value="/user/profile"/>
          <s:url var="url_cart" value="/user/cart"/>
          <s:url var="url_logout" value="/logout"/>


          <a href="${url_home}"><i class="fas fa-home"></i> Home</a>
          <a href="${url_orders}"><i class="fas fa-shopping-bag"></i> My Orders</a>

          <a href="${url_cart}"><i class="fas fa-shopping-cart"></i>Cart</a>
          <a href="${url_profile}"><i class="fas fa-user"></i> Profile</a>
          <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
      </nav>


    <main class="main-content">
        <c:if test="${not empty message}">
            <div class="message success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <c:if test="${not empty err}">
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i> ${err}
            </div>
        </c:if>

        <div class="cart-container">
            <c:choose>
              <c:when test="${empty cartItems}">
                  <div class="cart-empty">
                      <h3><i class="fas fa-shopping-basket"></i> Your cart is empty</h3>
                      <p>Looks like you haven't added any items to your cart yet.</p>
                      <div class="shop-cart">
                          <a href="<s:url value="/user/dashboard"/>" class="btn btn-primary btn-small">
                              <i class="fas fa-shopping-bag"></i> Continue Shopping
                          </a>
                      </div>
                  </div>
              </c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item">
                            <div class="cart-item-details">
                                <img src="${item.menu.image}"
                                     alt="${item.menu.itemname}"
                                     class="cart-item-image">
                                <div class="cart-item-info">
                                    <h4>${item.menu.itemname}</h4>
                                    <p>₹${item.menu.price} each</p>
                                </div>
                            </div>

                            <div class="cart-item-controls">
                                <form action="<s:url value="/user/update-cart-item"/>" method="post">
                                    <input type="hidden" name="cart_id" value="${item.cart_id}">
                                    <div class="quantity-control">
                                        <button type="button" onclick="decreaseQuantity(this)">-</button>
                                        <input type="number"
                                               name="quantity"
                                               value="${item.quantity}"
                                               min="1"
                                               readonly>
                                        <button type="button" onclick="increaseQuantity(this)">+</button>
                                    </div>
                                    <button type="submit" class="btn btn-secondary mt-2">Update</button>
                                </form>
                                <a href="<s:url value="/user/remove-cart-item?cart_id=${item.cart_id}"/>"
                                   class="btn btn-secondary"
                                   onclick="return confirm('Are you sure you want to remove this item?');">
                                    <i class="fas fa-trash"></i> Remove
                                </a>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="cart-summary">
                        <div class="cart-summary-details">
                            <h3>Order Summary</h3>
                            <p>Total Items: ${cartItems.size()}</p>
                        </div>
                        <div class="cart-summary-details">
                            <h3>Total Amount</h3>
                            <h3>₹<fmt:formatNumber value="${totalCartValue}" pattern="#,##0.00"/></h3>
                        </div>
                    </div>

                    <div class="cart-actions">
                        <a href="<s:url value="/user/clear-cart"/>"
                           class="btn btn-secondary"
                           onclick="return confirm('Are you sure you want to clear your entire cart?');">
                            <i class="fas fa-trash-alt"></i> Clear Cart
                        </a>
                        <a href="<s:url value="/user/checkout"/>" class="btn btn-primary">
                            <i class="fas fa-credit-card"></i> Proceed to Checkout
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <footer class="footer">
        <jsp:include page="include/footer.jsp"/>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const successMessage = document.querySelector('.message.success');
            const errorMessage = document.querySelector('.message.error');

            if (successMessage) {
                setTimeout(function() {
                    successMessage.style.opacity = '0';
                    setTimeout(function() {
                        successMessage.remove();
                    }, 500);
                }, 2500);
            }

            if (errorMessage) {
                setTimeout(function() {
                    errorMessage.style.opacity = '0';
                    setTimeout(function() {
                        errorMessage.remove();
                    }, 500);
                }, 2500);
            }
        });

        function increaseQuantity(button) {
            const input = button.previousElementSibling;
            let value = parseInt(input.value);
            input.value = value + 1;
        }

        function decreaseQuantity(button) {
            const input = button.nextElementSibling;
            let value = parseInt(input.value);
            if (value > 1) {
                input.value = value - 1;
            }
        }
    </script>
</body>
</html>