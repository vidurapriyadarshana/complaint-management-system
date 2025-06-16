<%--
  Created by IntelliJ IDEA.
  User: Vidura
  Date: 6/16/2025
  Time: 11:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="true" %>
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
        <a href="<%= request.getContextPath() %>/api/v1/logout">Logout</a>
    </body>
</html>

