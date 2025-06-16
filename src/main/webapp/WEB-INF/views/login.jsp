<%--
  Created by IntelliJ IDEA.
  User: Vidura
  Date: 6/16/2025
  Time: 11:34 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Login - Complaint Management System</title>
        <link href="../../css/login.css" rel="stylesheet">
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
            <form name="loginForm" action="<%= request.getContextPath() %>/api/v1/login" method="post" onsubmit="return validateLoginForm()">
                <input type="text" name="username" placeholder="Username" required />
                <input type="password" name="password" placeholder="Password" required />
                <input type="submit" value="Login" />
            </form>
            <a class="signup-link" href="<%= request.getContextPath() %>/api/v1/signup">Don't have an account? Sign up</a>
        </div>
    </body>
</html>
