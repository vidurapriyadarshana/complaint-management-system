<%@ page import="edu.vidura.model.bean.Complaint" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    String username = (String) session.getAttribute("user");
%>
<html>
    <head>
        <title>Employee Dashboard</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                max-width: 900px;
                margin: 50px auto;
            }

            h1, h2 {
                color: #004080;
                margin-bottom: 20px;
            }

            form input[type="text"],
            form textarea {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            form input[type="submit"] {
                background-color: #004080;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
                width: 100%;
            }

            form input[type="submit"]:hover {
                background-color: #003060;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 30px;
            }

            th, td {
                padding: 12px;
                border: 1px solid #ccc;
                text-align: left;
                font-size: 14px;
            }

            th {
                background-color: #004080;
                color: white;
            }

            .actions a {
                margin-right: 10px;
                text-decoration: none;
                font-weight: bold;
            }

            .edit-link {
                color: #008000;
            }

            .delete-link {
                color: #FF0000;
            }

            .actions a:hover {
                text-decoration: underline;
            }

            .actions span {
                color: #888;
            }
        </style>
    </head>
    <body>
    <div class="container">
        <h1>Welcome, <%= username != null ? username : "Employee" %></h1>

        <h2>Submit a New Complaint</h2>
        <form action="<%= request.getContextPath() %>/employee/dashboard" method="post">
            <input type="text" name="title" placeholder="Complaint Title" required /><br/>
            <textarea name="description" placeholder="Complaint Description" rows="4" required></textarea><br/>
            <input type="submit" value="Submit Complaint" />
        </form>

        <h2>Your Complaints</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Status</th>
                <th>Remarks</th>
                <th>Actions</th>
            </tr>
            <%
                if (complaints != null && !complaints.isEmpty()) {
                    for (Complaint c : complaints) {
            %>
            <tr>
                <td><%= c.getId() %></td>
                <td><%= c.getTitle() %></td>
                <td><%= c.getDescription() %></td>
                <td><%= c.getStatus() %></td>
                <td><%= c.getRemarks() != null ? c.getRemarks() : "-" %></td>
                <td class="actions">
                    <% if (!"RESOLVED".equalsIgnoreCase(c.getStatus())) { %>
                    <a class="edit-link" href="<%= request.getContextPath() %>/editComplaint?id=<%= c.getId() %>">Edit</a>
                    <a class="delete-link" href="<%= request.getContextPath() %>/deleteComplaint?id=<%= c.getId() %>"
                       onclick="return confirm('Are you sure you want to delete this complaint?');">Delete</a>
                    <% } else { %>
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6">You haven't submitted any complaints yet.</td>
            </tr>
            <% } %>
        </table>
    </div>
    </body>
</html>
