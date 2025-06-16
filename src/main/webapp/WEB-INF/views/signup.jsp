<%--
  Created by IntelliJ IDEA.
  User: Vidura
  Date: 6/16/2025
  Time: 12:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up - Complaint Management System</title>
    <link href="../../css/signup.css" rel="stylesheet">
</head>
<body>
<div class="signup-container">
    <h1>Sign Up</h1>
    <form action="SignupServlet" method="post">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="password" name="confirmPassword" placeholder="Confirm Password" required />
        <select name="role" required>
            <option value="" disabled selected>Select Role</option>
            <option value="admin">Admin</option>
            <option value="employee">Employee</option>
        </select>
        <input type="submit" value="Sign Up" />
    </form>
    <a class="signin-link" href="login.jsp">Already have an account? Sign in</a>
</div>
</body>
</html>

