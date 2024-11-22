<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact List - Contact Application</title>
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

        .contact-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .contact-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .contact-header h3 {
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

        .search-form button,
        .delete-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .search-form button:hover,
        .delete-button:hover {
            transform: translateY(-2px);
        }

        .contact-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .contact-table th,
        .contact-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .contact-table th {
            background: rgba(102, 126, 234, 0.1);
            color: #333;
            font-weight: 600;
        }

        .contact-table tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        .action-links a {
            color: #667eea;
            text-decoration: none;
            margin-right: 1rem;
        }

        .action-links a:hover {
            color: #764ba2;
        }

        .success {
            background: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 5px;
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


                }

        .checkbox-custom {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            .contact-container {
                padding: 1rem;
            }

            .contact-table {
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

            .contact-header {
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
    <header class="header">
        <h1><i class="fas fa-address-book"></i> Restaurant Manager</h1>
    </header>

   <nav class="navbar">

   <c:if test="${sessionScope.userId!=null && sessionScope.role == 1}">
       <%-- Admin is logged in : Admin Menu --%>
       <a href="<s:url value="/admin/dashboard"/>">Home</a>
       <a href="${url_restaurants}"><i class="fas fa-store"></i> Restaurants</a>
        <a href="${url_users}"><i class="fas fa-users"></i> Buyer</a>
       <a href="${url_seller}"><i class="fas fa-users"></i> Sellers</a>
       <a href="${url_users}"><i class="fas fa-users"></i> Buyer</a>
       <a href="${url_logout}">Logout</a>
   </c:if>


   <c:if test="${sessionScope.userId!=null && sessionScope.role == 3}">
          <%-- Admin is logged in : Admin Menu --%>
          <s:url var="url_home" value="/seller/dashboard"/>
                     <s:url var="url_restaurants" value="/user/clist"/>
                     <s:url var="url_seller" value="/admin/sellers"/>
                     <s:url var="url_users" value="/admin/buyers"/>
                     <s:url var="url_reports" value="/admin/reports"/>
                     <s:url var="url_logout" value="/logout"/>

          <a href="<s:url value="/seller/dashboard"/>">Home</a>
          <a href="${url_restaurants}"><i class="fas fa-store"></i> Restaurants</a>
           <a href="${url_users}"><i class="fas fa-users"></i> Buyer</a>
          <a href="${url_seller}"><i class="fas fa-users"></i> Sellers</a>
          <a href="${url_users}"><i class="fas fa-users"></i> Buyer</a>
          <a href="${url_logout}">Logout</a>
      </c:if>



         <%--   <a href="${url_home}"><i class="fas fa-home"></i> Home</a>

          <a href="${url_seller}"><i class="fas fa-users"></i> Sellers</a> --%>

          <%-- <a href="${url_reports}"><i class="fas fa-chart-bar"></i> Reports</a>
           <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>  --%>
       </nav>

    <main class="main-content">
        <div class="contact-container">
            <div class="contact-header">
                <h3><i class="fas fa-list"></i> Restaurant List</h3>

                <form action="<s:url value="/user/contact_search"/>" class="search-form">
                    <input type="text" name="freeText" value="${param.freeText}" placeholder="Enter text to search...">
                    <button type="submit"><i class="fas fa-search"></i> Search</button>
                </form>
            </div>

            <c:if test="${param.act eq 'sv'}">
                <div class="success">
                    <i class="fas fa-check-circle"></i> Restaurant Saved Successfully
                </div>
            </c:if>

            <c:if test="${param.act eq 'del'}">
                <div class="success">
                    <i class="fas fa-check-circle"></i> Restaurant Deleted Successfully
                </div>
            </c:if>

            <form action="<s:url value="/user/bulk_cdelete"/>">
                <button type="submit" class="delete-button">
                    <i class="fas fa-trash-alt"></i> Delete Selected
                </button>

                <table class="contact-table">
                    <thead>
                        <tr>
                            <th><i class="fas fa-check-square"></i></th>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Actions</th>

                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty contactList}">
                            <tr>
                                <td colspan="8" class="error">
                                    <i class="fas fa-info-circle"></i> No Records Found
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach var="c" items="${contactList}" varStatus="st">
                            <tr>
                                <td>
                                    <input type="checkbox" name="cid" value="${c.contactId}" class="checkbox-custom"/>
                                </td>
                                <td>${c.contactId}</td>
                                <td>${c.name}</td>
                                <td>${c.phone}</td>
                                <td>${c.email}</td>
                                <td>${c.address}</td>

                             <c:if test="${user.role != '1'}">
                                 <td class="action-links">
                                        <s:url var="url_edit" value="/user/edit_contact">
                                         <s:param name="cid" value="${c.contactId}"/>
                                         </s:url>

                                         <s:url var="url_add" value="/user/menu">
                                         <s:param name="cid" value="${c.contactId}"/>
                                         </s:url>
                                         <s:url var="url_view" value="/seller/menu_list">
                                            <s:param name="cid" value="${c.contactId}"/>
                                          </s:url>
                                        <s:url var="url_del" value="/user/del_contact">
                                        <s:param name="cid" value="${c.contactId}"/>
                                       </s:url>
                                      <a href="${url_add}"><i class="fas fa-edit"></i> Add Menu</a>
                                      <a href="${url_view}"><i class="fas fa-edit"></i> View Menu</a>
                                      <a href="${url_edit}"><i class="fas fa-edit"></i> Edit</a>
                                      <a href="${url_del}"><i class="fas fa-trash"></i> Delete</a>
                                     </c:if>

                          </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </form>
        </div>
    </main>

   <footer class="footer">
      <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
      </footer>
</body>
</html>