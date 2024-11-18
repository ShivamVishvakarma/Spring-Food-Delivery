<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - Registration</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <s:url var="url_jqlib" value="/static/js/jquery-3.2.1.min.js" />
    <script src="${url_jqlib}"></script>
  <script>
          $(document).ready(function (){
              // Check availability button click event
              $("#id_check_avail").click(function(){
                  $.ajax({
                      url : 'check_avail',
                      data : { username: $("#id_username").val() },
                      success : function(data){
                          $("#id_res_div").html(data);
                      }
                  });
              });

              // Live validation
              function validateField(field, validationFunc) {
                  const value = $(field).val();
                  const errorDiv = $(field).next('.error');
                  errorDiv.remove(); // Clear previous error message

                  const errorMessage = validationFunc(value);
                  if (errorMessage) {
                      $(field).after('<div class="error" style="color: red; margin-top: 5px;">' + errorMessage + '</div>');
                      return false;
                  }
                  return true;
              }

              // Validation functions
              function validateName(name) {
                  if (name.trim() === "") {
                      return "Name is required.";
                  }
                  if (!/^[A-Za-z\s]+$/.test(name)) {
                      return "Name can only contain letters and spaces.";
                  }
                  return null;
              }

              function validatePhone(phone) {
                  if (phone.trim() === "") {
                      return "Phone number is required.";
                  }
                  if (!/^\d{10}$/.test(phone)) {
                      return "Phone number must be exactly 10 digits.";
                  }
                  return null;
              }

              function validateEmail(email) {
                  if (email.trim() === "") {
                      return "Email is required.";
                  }
                  const validDomainPattern = /^[a-zA-Z0-9._%+-]+@(yash\.com|gmail\.com)$/;
                  if (!validDomainPattern.test(email)) {
                      return "Email must be from either yash.com or gmail.com domain.";
                  }
                  return null;
              }

              function validateUsername(username) {
                  if (username.trim() === "") {
                      return "Username is required.";
                  }
                  return null;
              }

              function validatePassword(password) {
                  if (password.trim() === "") {
                      return "Password is required.";
                  }

                  const minLength = 6;
                  const hasUpperCase = /[A-Z]/.test(password);
                  const hasLowerCase = /[a-z]/.test(password);
                  const hasNumbers = /\d/.test(password);
                  const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

                  let errors = [];

                  if (password.length < minLength) {
                      errors.push("at least 6 characters");
                  }
                  if (!hasUpperCase) {
                      errors.push("one uppercase letter");
                  }
                  if (!hasLowerCase) {
                      errors.push("one lowercase letter");
                  }
                  if (!hasNumbers) {
                      errors.push("one number");
                  }
                  if (!hasSpecialChar) {
                      errors.push("one special character");
                  }

                  if (errors.length > 0) {
                      return "Password must contain " + errors.join(", ");
                  }

                  return null;
              }

              function validateAddress(address) {
                  if (address.trim() === "") {
                      return "Address is required.";
                  }
                  return null;
              }

              function validateRole(role) {
                  if (!role || role.trim() === "") {
                      return "Please select a role (Buyer or Seller).";
                  }
                  return null;
              }

              // Add password strength indicator
              function updatePasswordStrength(password) {
                  const strengthIndicator = $("#password-strength");
                  if (!strengthIndicator.length) {
                      $("input[name='user.password']").after('<div id="password-strength" style="margin-top: 5px;"></div>');
                  }




              }

              // Prevent non-numeric input in phone field
              $("input[name='user.phone']").on('keypress', function(e) {
                  if (e.which < 48 || e.which > 57) {
                      e.preventDefault();
                  }
              });

              // Prevent numeric input in name field
              $("input[name='user.name']").on('keypress', function(e) {
                  var char = String.fromCharCode(e.which);
                  if (!/^[A-Za-z\s]$/.test(char)) {
                      e.preventDefault();
                  }
              });

              // Attach keyup event for live validation
              $("input[name='user.name']").on('keyup', function() {
                  validateField(this, validateName);
              });

              $("input[name='user.phone']").on('keyup', function() {
                  validateField(this, validatePhone);
              });

              $("input[name='user.email']").on('keyup', function() {
                  validateField(this, validateEmail);
              });

              $("#id_username").on('keyup', function() {
                  validateField(this, validateUsername);
              });

              $("input[name='user.password']").on('keyup', function() {
                  validateField(this, validatePassword);

              });

              $("textarea[name='user.address']").on('keyup', function() {
                  validateField(this, validateAddress);
              });

              $("select[name='user.role']").on('change', function() {
                  validateField(this, validateRole);
              });

              // Add requirement notes under password field

              // Form submission validation
              $("form").submit(function(event) {
                  let isValid = true;

                  // Validate all fields
                  isValid &= validateField($("input[name='user.name']"), validateName);
                  isValid &= validateField($("input[name='user.phone']"), validatePhone);
                  isValid &= validateField($("input[name='user.email']"), validateEmail);
                  isValid &= validateField($("#id_username"), validateUsername);
                  isValid &= validateField($("input[name='user.password']"), validatePassword);
                  isValid &= validateField($("textarea[name='user.address']"), validateAddress);
                  isValid &= validateField($("select[name='user.role']"), validateRole);

                  if (!isValid) {
                      event.preventDefault(); // Prevent form submission
                  }
              });
          });
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
            background: rgb(36 71 133);
            backdrop-filter: blur(10px);
            padding: 1rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
           position: fixed;
           width: -webkit-fill-available;

           z-index: 1000;

        }

        .header h1 {
            color: white;
            text-align: center;
            font-size: 2em;
            font-weight: 600;
        }

        .navbar {
            background: rgb(36 71 133);
            padding: 1rem;
            text-align: right;
            position: fixed;
            top: 65px;
            width: -webkit-fill-available;
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .registration-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            margin-top: 8rem;
        }

        .registration-container h3 {
            color: #333;
            margin-bottom: 1.5rem;
            text-align: center;
            font-size: 1.5em;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #666;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
            background-color: white;
        }

        .form-group select {
            cursor: pointer;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            background-size: 1em;
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: #667eea;
            outline: none;
        }

        .check-availability {
            background: #667eea;
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 0.5rem;
            font-size: 0.9rem;
            transition: background-color 0.3s ease;
        }

        .check-availability:hover {
            background: #764ba2;
        }

        .register-btn {
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

        .register-btn:hover {
            transform: translateY(-2px);
        }

        .message {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .error {
            background: #fafcfa;
            color: #0db80d;
            border-left: 4px solid #fafcfa;
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

        #id_res_div {
            margin-top: 0.5rem;
            font-size: 0.9rem;
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

            .registration-container {
                padding: 1rem;
            }
            .error-input {
                        border-color: #ff4444 !important;
                        background-color: #fff8f8 !important;
                    }

                    .empty-input {
                        border-color: #ffaa00 !important;
                    }

                    .validation-error {
                        color: #ff4444;
                        padding: 0.5rem;
                        margin: 0.5rem 0;
                        background-color: #fff8f8;
                        border-left: 3px solid #ff4444;
                        font-size: 0.9rem;
                    }

                    #validation-messages {
                        margin-bottom: 1rem;
                    }

                    .form-group input:focus.error-input {
                        border-color: #ff4444 !important;
                        box-shadow: 0 0 0 2px rgba(255, 68, 68, 0.2);
                    }

                    /* Helper text styles */
                    .helper-text {
                        font-size: 0.8rem;
                        color: #666;
                        margin-top: 0.25rem;
                    }
    </style>
</head>
<body>
    <header class="header">
        <h1><i class="fa-solid fa-burger"></i>  Online Food Delivery</h1>
    </header>

    <nav class="navbar">
        <s:url var="url_index" value="/index"/>
        <a href="${url_index}"><i class="fas fa-home"></i> Home</a>
        <a href="${url_index}"><i class="fas fa-sign-in-alt"></i> Login</a>
        <a href="#"><i class="fas fa-info-circle"></i> About</a>
        <a href="#"><i class="fas fa-question-circle"></i> Help</a>
    </nav>

    <main class="main-content">
        <div class="registration-container">
            <h3><i class="fas fa-user-plus"></i> User Registration</h3>

            <c:if test="${err!=null}">
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i> ${err}
                </div>
            </c:if>

            <s:url var="url_reg" value="/register"/>
            <f:form action="${url_reg}" modelAttribute="command">
                <div class="form-group">
                    <label for="name"><i class="fas fa-user"></i> Name</label>
                    <f:input path="user.name" id="name" placeholder="Enter your full name"/>
                </div>

                <div class="form-group">
                    <label for="phone"><i class="fas fa-phone"></i> Phone</label>
                    <f:input path="user.phone" id="phone" placeholder="Enter your phone number"/>
                </div>

                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email</label>
                    <f:input path="user.email" id="email" placeholder="Enter your email address"/>
                </div>

                <div class="form-group">
                    <label for="address"><i class="fas fa-map-marker-alt"></i> Address</label>
                    <f:textarea path="user.address" id="address" placeholder="Enter your address"/>
                </div>

                <div class="form-group">
                    <label for="role"><i class="fas fa-user-tag"></i> Role</label>
                    <f:select path="user.role" id="role">
                        <f:option value="" label="Select a role"/>
                        <f:option value="2">Buyer</f:option>
                        <f:option value="3">Seller</f:option>
                    </f:select>
                </div>

                <div class="form-group">
                    <label for="id_username"><i class="fas fa-user-circle"></i> Username</label>
                    <f:input path="user.loginName" id="id_username" placeholder="Choose a username"/>
                    <button type="button" id="id_check_avail" class="check-availability">
                        <i class="fas fa-check-circle"></i> Check Availability
                    </button>
                    <div id="id_res_div" class="error"></div>
                </div>

                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <f:password path="user.password" id="password" placeholder="Choose a password"/>
                </div>

                <button type="submit" class="register-btn">
                    <i class="fas fa-user-plus"></i> Register
                </button>
            </f:form>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>



</body>
</html>