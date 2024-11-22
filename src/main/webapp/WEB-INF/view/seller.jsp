<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List - Contact Application</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <s:url var="url_jqlib" value="/static/js/jquery-3.2.1.min.js" />
    <script src="${url_jqlib}"></script>
    <script>
        function changeStatus(uid, lstatus) {
            $.ajax({
                url: 'change_status',
                data: {userId: uid, loginStatus: lstatus},
                success: function(data) {
                    showNotification(data);
                }
            });
        }

        function showNotification(message) {
            const notification = document.createElement('div');
            notification.className = 'notification';
            notification.innerHTML = `<i class="fas fa-info-circle"></i> ${message}`;
            document.body.appendChild(notification);

            setTimeout(() => {
                notification.classList.add('show');
                setTimeout(() => {
                    notification.classList.remove('show');
                    setTimeout(() => notification.remove(), 300);
                }, 2000);
            }, 100);
        }
    </script>
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

        .user-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .user-container h3 {
            color: #333;
            margin-bottom: 1.5rem;
            font-size: 1.5em;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .user-table th,
        .user-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .user-table th {
            background: rgba(102, 126, 234, 0.1);
            color: #333;
            font-weight: 600;
        }

        .user-table tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        .status-select {
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .status-select:hover {
            border-color: #667eea;
        }

        .status-select option {
            padding: 0.5rem;
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

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background: white;
            padding: 1rem 2rem;
            border-radius: 5px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            transform: translateX(120%);
            transition: transform 0.3s ease;
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .notification.show {
            transform: translateX(0);
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            .user-container {
                padding: 1rem;
            }

            .user-table {
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
        }
    </style>
</head>
<body>
    <header class="header">
        <h1><i class="fas fa-users"></i> User Management</h1>
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
        <div class="user-container">
            <h3><i class="fas fa-list"></i> User List</h3>

            <table class="user-table">
                <thead>
                    <tr>
                        <th>SR</th>
                        <th>USER ID</th>
                        <th>NAME</th>
                        <th>PHONE</th>
                        <th>EMAIL</th>
                        <th>ADDRESS</th>
                        <th>USERNAME</th>
                        <th>STATUS</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${userList}" varStatus="st">
                        <tr>
                            <td>${st.count}</td>
                            <td>${u.userId}</td>
                            <td>${u.name}</td>
                            <td>${u.phone}</td>
                            <td>${u.email}</td>
                            <td>${u.address}</td>
                            <td>${u.loginName}</td>
                            <td>
                                <select id="id_${u.userId}"
                                        class="status-select"
                                        onchange="changeStatus(${u.userId}, $(this).val())">
                                    <option value="1">Active</option>
                                    <option value="2">Block</option>
                                </select>
                                <script>
                                    $('#id_${u.userId}').val(${u.loginStatus});
                                </script>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

     <footer class="footer">
            <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
        </footer>
</body>
</html>