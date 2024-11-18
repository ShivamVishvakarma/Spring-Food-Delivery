<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - User Profile</title>
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

        .profile-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .profile-header {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .profile-picture {
            width: 150px;
            height: 150px;
            background: #f0f0f0;
            border-radius: 50%;
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .profile-picture i {
            font-size: 4rem;
            color: #667eea;
        }

        .profile-details {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .profile-section {
            margin-bottom: 1.5rem;
        }

        .profile-section h3 {
            color: #333;
            margin-bottom: 1rem;
            border-bottom: 2px solid #667eea;
            padding-bottom: 0.5rem;
        }

        .profile-field {
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }

        .profile-field i {
            width: 30px;
            color: #667eea;
            margin-right: 1rem;
        }

        .edit-profile-btn {
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

        .edit-profile-btn:hover {
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

            .profile-field {
                flex-direction: column;
                text-align: center;
            }

            .profile-field i {
                margin-bottom: 0.5rem;
                margin-right: 0;
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
        <div class="profile-container">
            <div class="profile-header">
                <div class="profile-picture">
                    <i class="fas fa-user"></i>
                </div>
                <h2>${sessionScope.user.name}</h2>
                <p>Member since: January 2024</p>
            </div>

            <div class="profile-details">
                <div class="profile-section">
                    <h3><i class="fas fa-user-circle"></i> Personal Information</h3>
                    <div class="profile-field">
                        <i class="fas fa-user"></i>
                        <span>Full Name: ${sessionScope.user.name}</span>
                    </div>
                    <div class="profile-field">
                        <i class="fas fa-envelope"></i>
                        <span>Email: ${sessionScope.user.email}</span>
                    </div>
                    <div class="profile-field">
                        <i class="fas fa-phone"></i>
                        <span>Phone: ${sessionScope.user.phone}</span>
                    </div>
                </div>

                <div class="profile-section">
                    <h3><i class="fas fa-map-marker-alt"></i> Delivery Address</h3>
                    <div class="profile-field">
                        <i class="fas fa-home"></i>
                        <span>Address: ${sessionScope.user.address}</span>
                    </div>
                   <%-- <div class="profile-field">
                        <i class="fas fa-city"></i>
                        <span>City: ${sessionScope.user.city}</span>
                    </div>
                    <div class="profile-field">
                        <i class="fas fa-map-pin"></i>
                        <span>PIN Code: ${sessionScope.user.pincode}</span>
                    </div> --%>
                </div>

                <div class="profile-section">
                    <h3><i class="fas fa-cog"></i> Preferences</h3>
                    <div class="profile-field">
                        <i class="fas fa-bell"></i>
                        <span>Notifications: Enabled</span>
                    </div>
                    <div class="profile-field">
                        <i class="fas fa-language"></i>
                        <span>Language: English</span>
                    </div>
                </div>

              <s:url var="url_edit" value="/user/edit_contact">
              <s:param name="cid" value="${c.contactId}"/>
                 </s:url>
                <button class="edit-profile-btn">
                    <a href="${url_edit}"><i class="fas fa-edit"></i> Edit</a>
                </button>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html
