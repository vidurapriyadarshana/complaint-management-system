<%--
  Created by IntelliJ IDEA.
  User: Vidura
  Date: 6/18/2025
  Time: 11:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !"ADMIN".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/api/v1/login");
        return;
    }
%>
<html>
    <head>
        <title>Admin Dashboard</title>
    </head>
    <body>
        <h1>Welcome, Admin <%= username %>!</h1>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </body>
</html>
