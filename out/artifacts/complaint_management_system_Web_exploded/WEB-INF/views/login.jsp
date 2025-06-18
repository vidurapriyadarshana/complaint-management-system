<%--
  Created by IntelliJ IDEA.
  User: Vidura
  Date: 6/18/2025
  Time: 11:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Complaint Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        .login-container h1 {
            margin-bottom: 20px;
            color: #333;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .login-container input[type="submit"] {
            background-color: #004080;
            color: white;
            padding: 12px;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .login-container input[type="submit"]:hover {
            background-color: #003060;
        }

        .signup-link {
            margin-top: 15px;
            display: block;
            color: #004080;
            text-decoration: none;
        }

        .signup-link:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function validateLoginForm() {
            const username = document.forms["loginForm"]["username"].value.trim();
            const password = document.forms["loginForm"]["password"].value.trim();

            if (username === "") {
                alert("Username is required.");
                return false;
            }

            if (password === "") {
                alert("Password is required.");
                return false;
            }

            if (password.length < 6) {
                alert("Password must be at least 6 characters.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<div class="login-container">
    <h1>Login</h1>
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
    <div style="color: red;"><%= errorMessage %></div>
    <%
        }
    %>
    <form name="loginForm" action="<%= request.getContextPath() %>/login" method="post" onsubmit="return validateLoginForm()">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="submit" value="Login" />
    </form>
    <a class="signup-link" href="<%= request.getContextPath() %>/signup">Don't have an account? Sign up</a>
</div>
</body>
</html>

