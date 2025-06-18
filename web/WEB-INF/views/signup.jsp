<%--
  Created by IntelliJ IDEA.
  User: Vidura
  Date: 6/18/2025
  Time: 11:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Sign Up - Complaint Management System</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .signup-container {
                background-color: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 380px;
                text-align: center;
            }

            .signup-container h1 {
                margin-bottom: 20px;
                color: #333;
            }

            .signup-container input[type="text"],
            .signup-container input[type="password"],
            .signup-container select {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .signup-container input[type="submit"] {
                background-color: #004080;
                color: white;
                padding: 12px;
                width: 100%;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
            }

            .signup-container input[type="submit"]:hover {
                background-color: #003060;
            }

            .signin-link {
                margin-top: 15px;
                display: block;
                color: #004080;
                text-decoration: none;
            }

            .signin-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="signup-container">
            <h1>Sign Up</h1>

            <%
                String errorMessage = (String) request.getAttribute("error");
                if (errorMessage != null) {
            %>
            <div style="color: red;"><%= errorMessage %></div>
            <%
                }
            %>
            <form id="signupForm" action="<%= request.getContextPath() %>/signup" method="post" onsubmit="return validateForm()">
                <input type="text" id="username" name="username" placeholder="Username" required />
                <input type="password" id="password" name="password" placeholder="Password" required />
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required />
                <select id="role" name="role" required>
                    <option value="" disabled selected>Select Role</option>
                    <option value="ADMIN">Admin</option>
                    <option value="EMPLOYEE">Employee</option>
                </select>
                <input type="submit" value="Sign Up" />
            </form>
            <a class="signin-link" href="<%= request.getContextPath() %>/login">Already have an account? Sign in</a>
        </div>
    </body>

    <script>
        function validateForm() {
            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const role = document.getElementById("role").value;

            if (!username || !password || !confirmPassword || !role) {
                alert("All fields are required.");
                return false;
            }

            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }

            return true;
        }
    </script>

</html>
