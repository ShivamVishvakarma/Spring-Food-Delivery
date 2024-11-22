<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu - Food Delivery</title>
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

       .menu-container {
           background: white;
           padding: 2rem;
           border-radius: 10px;
           box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
           width: 100%;
           max-width: 1200px;
           margin: 0 auto;
       }

       .menu-header {
           display: flex;
           justify-content: space-between;
           align-items: center;
           margin-bottom: 2rem;
       }

       .menu-header h3 {
           color: #333;
           font-size: 1.5em;
       }

       .search-form {
           display: flex;
           gap: 1rem;
           margin-bottom: 1.5rem;
       }

       .search-form input {
           flex: 1;
           padding: 0.8rem;
           border: 1px solid #ddd;
           border-radius: 5px;
           font-size: 1rem;
       }

       .search-form button {
           background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
           color: white;
           padding: 0.8rem 1.5rem;
           border: none;
           border-radius: 5px;
           cursor: pointer;
           transition: transform 0.3s ease;
       }

       .search-form button:hover {
           transform: translateY(-2px);
       }

       .menu-table {
           width: 100%;
           border-collapse: collapse;
           margin-top: 1rem;
       }

       .menu-table th,
       .menu-table td {
           padding: 1rem;
           text-align: left;
           border-bottom: 1px solid #ddd;
       }

       .menu-table th {
           background: rgba(102, 126, 234, 0.1);
           color: #333;
           font-weight: 600;
       }

       .menu-table tr:hover {
           background-color: rgba(102, 126, 234, 0.05);
       }

       .add-to-cart-btn {
           background: linear-gradient(135deg, #00b09b 0%, #96c93d 100%);
           color: white;
           padding: 0.5rem 1rem;
           border: none;
           border-radius: 5px;
           cursor: pointer;
           transition: all 0.3s ease;
           text-decoration: none;
           display: inline-flex;
           align-items: center;
           gap: 0.5rem;
       }

       .add-to-cart-btn:hover {
           transform: translateY(-2px);
           box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
       }

       .quantity-input {
           width: 60px;
           padding: 0.3rem;
           border: 1px solid #ddd;
           border-radius: 4px;
           margin-right: 0.5rem;
       }

       .menu-table img {
           max-width: 100px;
           border-radius: 5px;
           box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

           .menu-container {
               padding: 1rem;
           }

           .menu-table {
               display: block;
               overflow-x: auto;
           }

           .navbar {
               text-align: center;
           }

           .navbar a {
               display: inline-block;
               margin: 0.2rem;
           }

           .menu-header {
               flex-direction: column;
               gap: 1rem;
           }

           .search-form {
               flex-direction: column;
           }
       }
    </style>
</head>
<body>
    <% if(session.getAttribute("userId")==null) {
         response.sendRedirect("/FoodDelivery/");
       }
    %>

    <header class="header">
        <h1><i class="fa-solid fa-burger"></i> Online Food Delivery</h1>
    </header>

    <nav class="navbar">
        <s:url var="url_home" value="/user/dashboard"/>
        <s:url var="url_restaurants" value="/user/restaurants"/>
        <s:url var="url_orders" value="/user/orders"/>
        <s:url var="url_cart" value="/user/cart"/>
        <s:url var="url_logout" value="/logout"/>

        <a href="${url_home}"><i class="fas fa-home"></i> Home</a>
       <%-- <a href="${url_restaurants}"><i class="fas fa-store"></i> Restaurants</a> --%>
        <a href="${url_orders}"><i class="fas fa-list"></i> My Orders</a>
        <a href="${url_cart}"><i class="fas fa-shopping-cart"></i> Cart</a>
        <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </nav>

    <main class="main-content">
        <div class="menu-container">
            <div class="menu-header">
                <h3><i class="fas fa-utensils"></i> Menu Items</h3>

                <form action="<s:url value="/user/menu_search"/>" class="search-form">
                    <input type="text" name="freeText" placeholder="Search menu items...">
                    <button type="submit"><i class="fas fa-search"></i> Search</button>
                </form>
            </div>

            <c:if test="${not empty message}">
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> ${message}
                </div>
            </c:if>

            <table class="menu-table">
                <thead>
                    <tr>
                        <th>Item Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Category</th>
                        <th>Image</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty menuList}">
                        <tr>
                            <td colspan="6" class="error">
                                <i class="fas fa-info-circle"></i> No Menu Items Found
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="menu" items="${menuList}">
                        <tr>
                            <td>${menu.itemname}</td>
                            <td>${menu.description}</td>
                            <td>₹${menu.price}</td>
                            <td>${menu.foodCategory}</td>
                            <td>
                                <c:if test="${not empty menu.image}">
                                    <img src="${menu.image}" alt="Menu Item">
                                </c:if>
                            </td>
                            <td>


                              <form action="<s:url value='/user/add-to-cart'/>" method="POST" class="cart-control">
                                <input type="hidden" name="menuId" value="${menu.menuId}">
                                  <input type="hidden" name="cid" value="${menu.contactId}"> <!-- Add this hidden input -->
                              <div class="quantity-control">
                                       <button type="button" onclick="decreaseQuantity(this)">-</button>
                                         <input type="number"
                                            name="quantity"
                                              value="1"
                                              min="1"
                                              class="quantity-input"
                                               readonly>
                                             <button type="button" onclick="increaseQuantity(this)">+</button>
                                           </div>
                                            <button type="submit" class="add-to-cart-btn">
                                             <i class="fas fa-cart-plus"></i> Add to Cart
                                              </button>
                                                </form>

                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

     <script>
                 document.addEventListener('DOMContentLoaded', function() {
                       const successMessage = document.querySelector('.success-message');
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

    <footer class="footer">
        <jsp:include page="include/footer.jsp"/>
    </footer>
</body>
</html>